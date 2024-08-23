Return-Path: <netdev+bounces-121320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2DC95CB55
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 13:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24DD1C224E0
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 11:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5059187323;
	Fri, 23 Aug 2024 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NclLPKMw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2413A1E89C;
	Fri, 23 Aug 2024 11:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412335; cv=none; b=VMG6mWs7SeuipcNpB4gytyU8cb70nUnqFEkeIHF5BBJ6jSMYbsA+qi+T2h5YoBlGKKWx6KUmjCkAbKTRYHWJ4aJyp69AEmwl7h1JGVlS5NejhpBBlYZ3C6ks7rZaKQFCUH91+fHAdIN6LRHnETRByd7Ht197G74B/PKSMnOrvn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412335; c=relaxed/simple;
	bh=6uGqft5RWsJ4fj6CsF3sr3+D2VV0YYpJf7EJFcWj0Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Girf4vKfWxt8ECvkCfqTdiyuyzl1nhQZQ7awDPG5abIQAGOmwtSNZixtF2llgI2UV3MZIIrdD1LQAfodNsz4G9HIeuO7/znRhRsM8et81svZyiEltp7VHCAIzJFHas/0HU66P/Jf5Ekmy4sVYRUamEQFz7EZxwFyAh+vZMb0zhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NclLPKMw; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6b4412fac76so17303157b3.1;
        Fri, 23 Aug 2024 04:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724412333; x=1725017133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgLcsDJ1rGtU1f7pbspf9pH0cVjS36T3natW/Fq7ym8=;
        b=NclLPKMw9c5Ezh834lvhv4uDsbbTXmqLZkGw7crCEMpPGEqI/QKqNxy891r8WxF2cv
         GrDx4TNUxZWiCQodYktN8oDv31LbR+e+mCiaQUH8TpXykh4eUBKOcCXxTWwmqHYdqP/f
         G0DhqOxBmzkHKu0dHD3cirRf6Qhb9D5lzj5tjopgt2WcU8s/zUR6oCoRaWDXGA/F0EU3
         wkYO67NGUl9NIg60jwI5FXQHiSp7VTTJjd8Z8Uaje6lGra+N3fw2bFKtThjjYax5TTHB
         ljuAc9KeJOQnTAJOvDl1UXMnwytZsLPmS7erW0Zf9bLGmSorBdfCvYqKxVZ5ygVj7C60
         J+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724412333; x=1725017133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgLcsDJ1rGtU1f7pbspf9pH0cVjS36T3natW/Fq7ym8=;
        b=SjlZIikVRyt17EqJKexwZHe27Q/smeAqNQGx+QyANYDPGO69daHP5kwIsMFLoQHxKB
         cDAz8OVlwiMeeNEQ5tD/4sh9ifzCNYF1+iwwUdE8KXOeViCrjYsYsQ4aRR8IHzpwlZ/d
         ba4U9yLunzRSPP5oDM9od8L0nT4m3IU9rgN3WtTTgU8iarTDLIoi2gS9uC5gsFIcu4WN
         ZWpOz987BGov7+3XN5ltzKoMKtpf9ub4tsv2jIBlxqYKeFW8T1pHyNHzvMPjllYfBZB8
         q13tWT1vOOg6BmRuFmXPoO3i2UiALtlRWzkQnVSfV9uqQq/+cYR8Qmi7EaRyfddFb0KW
         zwIA==
X-Forwarded-Encrypted: i=1; AJvYcCVaRLVpM+wwBMI2bT8gcMF/5kiPTXfrPPOUHkXZ/nrdJ6nLVeaTLea73Pi/CGCThrxx7e7KeMj5@vger.kernel.org, AJvYcCXgF3OMWwJZath43t6SAjEQfQ0Q7Arjpw3m7Ya3A3pYQQmLBhcPIWe3S6+w0TkoPdimI8VsMa9zSW9EJBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvgTHSDb8on1cPwecSyCTXFVKaPZsDn8aNJcReJcH67wR9NiRm
	Cq5HA/jpPmWScXXcW2OeOUo9Bh8eiMnBdecgZ6zilCw+ggs5orFTiT4vDrA2hgGTr8/zjF0e7k/
	KDu8RlJYJUlWRI08EzVPZmePTz9Y1fOu3
X-Google-Smtp-Source: AGHT+IEYORL0mYqtQdjUXfYBdnRmYhaE6Ni6wnFvlJu03g3aq5V4LTkfCW6DXd/1pB3hupQZuzSYCSl1QJVm/BTloVk=
X-Received: by 2002:a05:690c:3241:b0:6be:92c7:a27e with SMTP id
 00721157ae682-6c6286b8f29mr18795587b3.28.1724412332929; Fri, 23 Aug 2024
 04:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819122348.490445-1-bbhushan2@marvell.com>
 <20240819122348.490445-2-bbhushan2@marvell.com> <20240820153549.732594b2@kernel.org>
 <CAAeCc_=Nmh25RDaY4SA2CHsu2mqgdtKEo62b4QKSV4V8icHMMw@mail.gmail.com> <20240822074845.5f932d6d@kernel.org>
In-Reply-To: <20240822074845.5f932d6d@kernel.org>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Fri, 23 Aug 2024 16:55:21 +0530
Message-ID: <CAAeCc_mOjgWbftER2VmzK747D2gqqGqXrX29WeD+eRWkd-hqdw@mail.gmail.com>
Subject: Re: [net-next,v6 1/8] octeontx2-pf: map skb data as device writeable
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, jerinj@marvell.com, 
	lcherian@marvell.com, richardcochran@gmail.com, b@mx0a-0016f401.pphosted.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 8:18=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 22 Aug 2024 09:15:43 +0530 Bharat Bhushan wrote:
> > On Wed, Aug 21, 2024 at 4:06=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > On Mon, 19 Aug 2024 17:53:41 +0530 Bharat Bhushan wrote:
> > > > Crypto hardware need write permission for in-place encrypt
> > > > or decrypt operation on skb-data to support IPsec crypto
> > > > offload. So map this memory as device read-write.
> > >
> > > How do you know the fragments are not read only?
> >
> > IOMMU permission faults will be reported if the DMA_TO_DEVICE direction=
 flag
> > is used in dma_map_page_attrs(). This is because iommu creates read onl=
y mapping
> > if the DMA_TO_DEVICE direction flag is used.  If the direction flag use=
d in
> > dma_map_pages() is DMA_BIDIRECTIONAL then iommu creates mapping with
> > both read and write permission.
>
> The other way around, I understand that your code makes the pages
> writable for the device. What I'm concerned about is that if this
> code path is fed Tx skbs you will corrupt them. Are these not Tx
> skbs that you're mapping? Have you fully CoW'd them to make sure
> they are writable?

This code is mapping skb data for hardware to over-write plain-text with
cypher-text and update authentication data (in-place encap/auth).
This patch series doesn't take care of CoWing for skb data. Actually I was
not aware of that before your comment.

To understand your comment better, If the device writes to shared skb data
without CoWing then we have an issue. Is that correct?

I do not see any other driver supporting IPsec crypto offload ensuring
skb data CoWing,
but there is a possibility that those devices are not doing in-place
encap and auth (encap
and auth data written to separate buffer). I do not have clarity about
this, This skb is set for
IPSEC crypto offload, Is this the driver which has to ensure that the
skb is writeable or the
network stack (xfrm layer) will ensure the same. If it is former then
add code to call skb_unshare().
Please suggest.

Thanks
-Bharat

