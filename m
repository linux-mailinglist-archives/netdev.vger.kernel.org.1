Return-Path: <netdev+bounces-267044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHFQGLCysmmYOwAAu9opvQ
	(envelope-from <netdev+bounces-267044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:33:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAF2271D42
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C0FE304D941
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75373126D7;
	Thu, 12 Mar 2026 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vLIwBKRC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E8C262FC1
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318807; cv=pass; b=qcZ5AExKb5FtXnxn3EWqgMQGy45Besu/SO2+YEWWfR40Kxo7EUsVclxiZbT/lX8rpCAef5AUOrs0Drmm6qpPdjmEJ7RFjqag/YZZhb0PxuMnF/B5bX5IiOcq1qtQJoWeP+jkSz3bpJjC/mduXq2bhbBwqjmXvACquM4LVNtqC4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318807; c=relaxed/simple;
	bh=GXw8Iyq3lCsZ1P8r9KzQgugq8QuWuRmGoPJyh8WeZIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQqr+4iVndy7Y7WqHHX54xUwG7aw0VIoQw/Aa3v3PVBTZo3HmZrEnCwn7Yn/ULZRX+QzP9g/OJUWd0+ykJXZizUsGEoIXGSV7x4GQ9Fzq7HzjdtJvBVrAz2YDT3Y8UcIA1kmabM3qFdCphUzaG5bmHQ4X9MxvF/7cZnYV8x+8aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vLIwBKRC; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89a0ece9f14so11142096d6.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 05:33:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773318805; cv=none;
        d=google.com; s=arc-20240605;
        b=JMrGBeQvdJjPncgaSNUCkICwQEZLkceqXsjpCCi3ikGHsYMXlSduOPon26YpsmnKN/
         bbfjVPCu81IGWtRsP6LTMVGmLmVxNaJR7f+Lf9fbkPkGHlXSUF3S4Mvx104Z30tr/KU3
         CK7d6nydWgwfSJJTlaMELOrIzE3XzR0Ob9cBIgTSz0Fdf16mssuUIyOqSDfJLafUqQt7
         +DqnkPmm5kg+l+/31sPmjDwRf77u7Wxt82tBjF8YOfWQn8/cArxIQ1r7jc2JyLjpDI0m
         lbqrof8VNCVYqYJXLVUDphE2vwNpu4ciNc2Ffqx2bDSTjzX97yUWKLSM2qRQPsVHWGrU
         IlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GXw8Iyq3lCsZ1P8r9KzQgugq8QuWuRmGoPJyh8WeZIg=;
        fh=pAgIPGeWwB7JhwP53Y5CCRaEt+s72vZVie4KoiMqHmc=;
        b=VWc5lilMFt24r94+vkr5Cbo4+v+x23FPR3vzCM5ZZ2zx2bm+D+059QEgllyraVOi2p
         N2M8pWQYKrwQNP2T4/ObF2mLkv1TUTmjTK7PC2GHOBwMc2muFl6ScjZ6qnvLxIg9Dy/9
         +YH/ycJAU2J7hVEv2mW6WwrBUOnTZZEcqIfFraZl7zFZjsOFGxDRun/nua3YSmvsvuQM
         pN3ZtZSYu18CdgiCgh9fBgpBWqwtYhzVN0QL6EOaMpgpLNX7F01D4UcpY7F9xxns7AI5
         yZ2GF/MsFEvOXC+6iC1QiYalidxKakrpAWxBVfqPsEqBQUT0Dg3zMHEsFAlDniysP/Mm
         /3rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773318805; x=1773923605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXw8Iyq3lCsZ1P8r9KzQgugq8QuWuRmGoPJyh8WeZIg=;
        b=vLIwBKRCKRmA9Nqmi/cx7RGdn5IWDTDvohCGVyZnXoqHvqOXZkRUTKXoMqrztWjk5E
         YkgA6qD8lfnKWC4onQJy99BVeZM2oiwq4gigx6SRjw5W7BaDKhdzY+fxBvZX8yt7yzii
         uo09sAZiJEUgMJtQUNmyoeDn0ZN9hwM5Q0d9ld4Hnk/3TqFRz/tZa3cBRSExZtEkE98o
         ytTOiaGg6mX1kstoJB9tMRbFi1hEMkpMYtkPn57g68tqdx0mRS0YQjAZWvD2rE54R1W8
         t6XfFuYrMgeLwS79zWEWt7/Yie1wM4YnUkzC+vUZcW66uOCfSIKn9cUiwg8cxBx2T734
         abww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773318805; x=1773923605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GXw8Iyq3lCsZ1P8r9KzQgugq8QuWuRmGoPJyh8WeZIg=;
        b=awtNyaIvs7uXEKvuSsDwHrKHRQeekQ0m6n2lr7+peETxio/yKblobzKdBdcIcDIpoX
         CxJV1TMc6l0qvz3dZqSU7t52hBt4R630+JjCpPq0kHorTJ83UOBGUubqn6muF1gSjRp9
         fkcu6+R3slf0vdpBqfz/qDrkktKJFVNIbPcZ+Y/x+qCVwBlJHLO3F0vjOfntydIpRu4O
         xz/yHAY5M/orhjxuC3iE7/UsC2MmSD4BHXdt7/DsdtzRe99uugxVMQbH5AABH1tT+h7M
         GYfc796MmR6xRNwWmBs7QS0oUuAi/Qcw8gNhjiVAbA1KdfN10I0DrLWr42PfxAhueIgD
         dCZw==
X-Forwarded-Encrypted: i=1; AJvYcCXnQSaC5qnyJsl8h3HvoCDi7GmJOuhu3Ia/WxPkLxUsjh5gc8VaBK+SnqiyhR1KpxQ/sOxzjCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIvXSzw78NHC8u/7y/TvDIfKJr5Nm/nREcLYapUO1dNdSvSKh1
	7RRXI56Q220k33gM8yhD+Oo9Pe0E1VtcbM953NYszKttj3jdaOs8yaDW2USnhLY03TUOVj+Eboc
	3OxHE1GDlDRM9QaxtoyG143INIaCW9mFz29pBgyIR
X-Gm-Gg: ATEYQzzCJb4i3HSB4CmE2ZwX6zIhDfERo8JM4fhIGAmPkzRBklBZXeCTW1gpozu4zLe
	PNuhcIsCriL4rgxY392je5b2cwYtBuyG3fuTFl4SDWMcIYxhLc7ALisJqlNNhmvTJmMHVumbkHK
	kfCMXeUNcGJzWPTuUuJqHRJUnlzMxjxtLre1dVJSClgNJ2SQyX0PeenPwh8OE3lDd4StWStBikl
	Ig4l5jMoHmpBURjDpSWiH6IDU1CQMWn7gSeMXfMUX8BZFkDgrolhklM8gjVeHo1Emz6gTzTFPWj
	2+RO8Mpu
X-Received: by 2002:a05:6214:d6f:b0:899:f0b1:7332 with SMTP id
 6a1803df08f44-89a66a7a076mr87211586d6.32.1773318804540; Thu, 12 Mar 2026
 05:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310124451.2280968-1-edumazet@google.com> <d335d51f-6c42-4d9a-aa3f-4c8a2802ef44@redhat.com>
In-Reply-To: <d335d51f-6c42-4d9a-aa3f-4c8a2802ef44@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Mar 2026 13:33:13 +0100
X-Gm-Features: AaiRm52YGVftE6r19yavRmf6d-u6ayIrWPgoN85-MCU6a_IOZU46NO-rkBNl5kk
Message-ID: <CANn89iLZWQdpZx-4P2Cb1=90dwMrXrDdJH3ZCCt1K9z+NwiWig@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add tcp_release_cb_cond() helper
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-267044-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CEAF2271D42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 1:27=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 3/10/26 1:44 PM, Eric Dumazet wrote:
> > Majority of tcp_release_cb() calls do nothing at all.
> >
> > Provide tcp_release_cb_cond() helper so that release_sock()
> > can avoid these calls.
> >
> > Also hint the compiler thar __release_sock() and wake_up()
>
> I took the liberty of fixing the above typo while applying the patch.
>
> > are rarely called.
>
> For my education: out of sheer ignorance and lack of relevant H/W to
> actually measure the thing, I thought that on very high speed link with
> big TCP enabled, user-space process and BH processing running on
> different CPUs backlog usage would be quite probable?!?

Yes, but in this case each system call pumps in or out a lot of data.

Majority of data center traffic is RPC, overall probability of calling
 __release_sock()
is less than 5 %.

I mostly see that by looking at the difference between non FDO compilations
and FDO kernels.

Thanks !

