Return-Path: <netdev+bounces-96477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2758C6134
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 09:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE251F23D52
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 07:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201AC41C76;
	Wed, 15 May 2024 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rd9aLnKB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FCC42049
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757046; cv=none; b=QGi9SbnotbNoz00Tub94imb0510h8av3T3UWjzQdDSSTmunhVPCFdqMV0lgmTtEAPHvUZTXqnOuPWuRYjrAfJsWTm/OzCQbN9PftJM5pJ126eAt/JsgUBmOmDGVE0eFS82vK8GY5uZnJf56uw9Muu3Ng2rFxhX9ItkIgxEsPBJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757046; c=relaxed/simple;
	bh=ICLbvzuqZxXKEcEKoFwxYO9SDRjt2Rc5pfNPeqRwhFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhNn1xIitmdNoAq9pYWNyZcL73zVyF9p+AyJI2bMWtxlsCnYBZc/93IFBjRTyZMh5r+0vxkNSye4UF9c3eHTzPzAaeS2WEcU01dzY45A7y3tLJ+HX9uvnXYnn8T7LlHU3DeTy8/4W6o5YKAX9SeyvIxXWSj+k6AhbN1yJ2o/ozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rd9aLnKB; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso25584a12.1
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 00:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715757042; x=1716361842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICLbvzuqZxXKEcEKoFwxYO9SDRjt2Rc5pfNPeqRwhFQ=;
        b=rd9aLnKB6lgYW7H3zQx0Ci+IfSApKbk60tiDeovgtVW2mbjUwLi0SwMVIvLlSTkiMh
         skvRuPdRsEGT7gq7p75fylYKiYHDKbp5rt+UiYLxeWp5xAvBTQagZefkEH5d78SPIEj6
         KPGuveK7MVnB2YdF6OtQp0Ld8jUVxhnuiUullhE8mecnie72YALCDk4kdQPs/39scSaj
         xhYVkuF3RUbCw6Y4j85w6MHuxxs6Lga69KjIIuTjs4U6aA2Rsdgz4mgrCdaj0nNVURBG
         OEbQZ+QTCXXSMZkn+qss8YPyvcDZw6yY8Lt8m45JEuMXYDtVw2pJF3dtTIBcC0klqL8q
         Tm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757042; x=1716361842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICLbvzuqZxXKEcEKoFwxYO9SDRjt2Rc5pfNPeqRwhFQ=;
        b=W5M03gpAVYPRwHppYDnHtf/+qZW5g/LU3uvfI/ZzwqhvqEnWaIKriqMiUz4IXvALFc
         M3Nv70YKbdPb2Z9MgxLSHKivYhwNna9tVoDAzq2wrIn8rlGew7KdG0Z6/qRlXwTJCXWo
         OaVBOZ1ZCJ6cAHJ/eDvxnSbBu7HCfZ+O0g0yZ7AH0GlTi2dhNgB81KgFoNH9RaXvALw8
         5Ra1kFeLd0hjVcAbfHjMMemWdgptIndZPLwJpn6p3d4wQ/fEMtVy9C5MC+6JHGWZQTdv
         i8Mgkk/nKVIf3QvwNX08HnJEA3MJ/bQGlbQPq3QnJqfyJNlnhy5gw87YoapPDLCPVJ0e
         CPOg==
X-Forwarded-Encrypted: i=1; AJvYcCWmRa5ADvVXyt+oZEUxLIP0PTGlIvjSTxgbIGceisdLf4QCXY0X8OJQ1qj+7cus5oKISbAgQPn14eyObyNW/BBcSOApmEfG
X-Gm-Message-State: AOJu0YyTPB/9YrEJcdjfqPP6RLqqASxNKHTilzmjXxc0ljB2irgV8sKa
	Nq483ONXXAKlkfKaelhb4LpoUJwXuaa1odGOgMMkyGboN3CaOVSb7hsfBvApi4TjE7rNYQ0AdV6
	pP74YgofGPHWC4WPdgdm488SmSXbV89vtZnfP
X-Google-Smtp-Source: AGHT+IF5K0T0Yeo7tKJCWbAY81/dMIqr/qSLbhS1CvxbTPuH7xjR3qhYv9FbUlxL5PDoV1W4sqUV8BGMEoaw7uz+Ns8=
X-Received: by 2002:a50:c90b:0:b0:572:a33d:437f with SMTP id
 4fb4d7f45d1cf-5743a0a4739mr694830a12.2.1715757042144; Wed, 15 May 2024
 00:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7ec9b05b-7587-4182-b011-625bde9cef92@quicinc.com>
In-Reply-To: <7ec9b05b-7587-4182-b011-625bde9cef92@quicinc.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 May 2024 09:10:28 +0200
Message-ID: <CANn89iKRuxON3pWjivs0kU-XopBiqTZn4Mx+wOKHVmQ97zAU5A@mail.gmail.com>
Subject: Re: Potential impact of commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
To: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
Cc: soheil@google.com, ncardwell@google.com, yyd@google.com, ycheng@google.com, 
	quic_stranche@quicinc.com, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 6:47=E2=80=AFAM Subash Abhinov Kasiviswanathan (KS)
<quic_subashab@quicinc.com> wrote:
>
> We recently noticed that a device running a 6.6.17 kernel (A) was having
> a slower single stream download speed compared to a device running
> 6.1.57 kernel (B). The test here is over mobile radio with iperf3 with
> window size 4M from a third party server.
>
> The radio conditions are the same between the devices so that maximum
> achievable download speed will be the same. Both devices have the same
> tcp_rmem values.
>
> We captured tcpdump at the device and the main difference was that the
> receiver window advertised in the ACKs was going upto a maximum of ~2M
> in A vs ~6M in B. By explicitly increasing the window size in iperf3 in
> A, the download speed of A was able to match that of B which suggests
> that the RTT was high and needed a larger window size to achieve the
> download speed. We do not have tcp_shrink_window enabled.
>
> We noticed that there were some changes to window size done in commit
> dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale"). After
> reverting this commit in A, we observed that the receiver window
> advertised in ACKs matches B.
>
> We logged free_space, allowed_space and full_space in
> __tcp_select_window() in both devices and observed that the
> allowed_space was 6MB+ on both devices, however the full_space was
> smaller in A as the tp->window_clamp was smaller. The free_space was
> smaller in A compared to B which I believe is an expected consequence of
> the commit.
>
> Could you please advise on how we need to handle this. We are open to
> trying out any debug patches.

Hi Subash

I think you gave many details, but please give us more of them :

1) What driver is used on the receiver side.
2) MTU
3) cat /proc/sys/net/ipv4/tcp_rmem

Ideally, you could snapshot "ss -temoi dst <otherpeer>" on receive
side while the transfer is ongoing,
and possibly while stopping the receiver thread (kill -STOP `pidof iperf`)

TCP is sensitive to the skb->len/skb->truesize ratio.
Some drivers are known to provide 'bad skbs' in this regard.

Commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale") is
simply a step for dynamic
probing of skb->len/skb->truesize ratio, and give incentive for better
memory use.

Ultimately, TCP RWIN derives from effective memory usage.

Sending a too big RWIN can cause excessive memory usage or packet drops.
If you say RWIN was 6MB+ before the patch, this looks like a bug to me,
because tcp_rmem[2] =3D 6MB by default. There is no way a driver can
pack 6MB of TCP payload in 6MB of memory (no skb/headers overhead ???)
This would only work well in lossless networks, and if receiving
application drains TCP receive queue fast enough.

Please take a look at these relevant patches.
Note they are not perfect patches, because usbnet can still provide
'bad skbs', forcing TCP to send small RWIN.

d50729f1d60bca822ef6d9c1a5fb28d486bd7593 net: usb: smsc95xx: stop
lying about skb->truesize
05417aa9c0c038da2464a0c504b9d4f99814a23b net: usb: sr9700: stop lying
about skb->truesize
1b3b2d9e772b99ea3d0f1f2252bf7a1c94b88be6 net: usb: smsc75xx: stop
lying about skb->truesize
9aad6e45c4e7d16b2bb7c3794154b828fb4384b4 usb: aqc111: stop lying about
skb->truesize
4ce62d5b2f7aecd4900e7d6115588ad7f9acccca net: usb: ax88179_178a: stop
lying about skb->truesize

