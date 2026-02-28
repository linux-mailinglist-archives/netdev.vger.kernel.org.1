Return-Path: <netdev+bounces-262212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPJpLW9io2myBQUAu9opvQ
	(envelope-from <netdev+bounces-262212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:47:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AE91C93F2
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9D2430FED76
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 20:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7242D0C79;
	Sat, 28 Feb 2026 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BP6YHsWi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F7925DB12
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772310622; cv=none; b=po1xF6TsrmuKjuSO6nKKgX7RU1WVmrkFTaYW1bj1na3cv8ZCmmpd/mlYKWbhNmtPrSWsZS5vv4Bf+uzFMa5+gnW4Oi5s576xh2WoLk+mgS5HylASJ8Q+YUltOz+dzZ3aVC5ClVA9HVFsAV86+uL7RM4HC+U0bVHZQYLoobL1Pxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772310622; c=relaxed/simple;
	bh=4074zt5bpOL7TolVuAmUfn+0Hry0Ban+kCkioaWnFBU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NPJ5EEXr2RPg1z1mwnWc75IUaaV++PA/DXeGMq+Ye/Lsatmd47uXn2p8JUZMlnRrISpuhMHHMkNqCtwr8Ju07wEggaJ/YDOqL0hyXUcVnzGmanicVIU2iVvYJ3hIfBYbf3H2d3xwax3BelGk1XiPw3HzRbQk7ha3SXdJ+hjas3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BP6YHsWi; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79860421382so28886887b3.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 12:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772310619; x=1772915419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4/PHgdImLU0t3MEoKpGi0JejsOQalQw+IM1APjX0G8=;
        b=BP6YHsWiFXhzch2YEk91ocxwBJT/kwZCsQonTbjsDFaF4yWirHFh8LmCPydmnWNCTh
         j4Zfkrg9nMDZAEh2AN0nZ/TBP3KEMMEIeXGU97Rjba005ofhAqENWfHHvPc9mDVbFXYe
         jmFamEhw/Dfy/+pBmLNNk41gXz9vMtrsNfaieaTXJ86SoAhcjY87y4rOvmHCTzW85LWc
         76ibhA2i/o7sL5HPeX8JPSf3l1nHyAHF/fa/xV1FMIG3aMfMxeGv0dSVlxhTCwaLumxZ
         rSwYTpFoGXKSIauLz2AlwwuOD307i/F9joUzTJwW9njlQha9f3pn+2mJ206Ozn9LIPLh
         ijlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772310619; x=1772915419;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P4/PHgdImLU0t3MEoKpGi0JejsOQalQw+IM1APjX0G8=;
        b=uIeb6RNrv2gmAnotT8vk8KiW/bhm17lYe/5/aeBaBAeDxJyNLEZvt20eDZmODKt2m0
         nW9viNf6YuyILlx5RF1Vn5QSDVsM6PdsLTRYkY8oJtJgcdbqP9SKKjewUiM5AZxTAx/C
         jRVLYv1X7eLUihu+JuCHe5s1PQTK+LMx085RrxvwEceq5p9PcnDj1PMJFspqAxRl6/i3
         dL84NVyqlpY/aWIpAC0mjbEHCfEZWOt6xM48Ec8GorhCfYybSFNUm96/oY4xAW180HzI
         yi0/7RaJxdDVvfHtpDjpZnuvlmdIqJNmBCn0sABHNikd7qrcqytQKBoKAQ1YGqqsOkp2
         Q0ww==
X-Forwarded-Encrypted: i=1; AJvYcCWPXH1PbhMEZfW4AsryTrSyg1vvWNNN3B9iY/TevW6RU/sd2CS/gYMz45vukyiJ9J9Vjvr+ywk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9KzI9K1SZOMkn3k7sjLmdMx2ANfZC3e+YU9zCF3pOd99QIP5y
	ocdFOQPBWwNckOAbsthDdIlZrMg24EeWvAQlCBd2R176xF5ytQ5ZLURi
X-Gm-Gg: ATEYQzw0gJoNJ2oVpu4QV6unCi0Uo/Ra0ppnrjXLMN987VVeJACBS/6PivauAJv8gsF
	h9LkzBwEdr0SYJBZPZmUDT3p3o0Xho2HjVpubMnoLLbPoBkIodbQc54iG3mIKr5nKxUVgDcuHkl
	u1FCERhdWfzzc3YIXzdSMhD8j+FTFXidhOcK0ONHNcAeSskN98PhZm2Y/zhbB4ikUXOLyxYPKzq
	ae8iB0gfgxzX71vHyD0/aUAFdaP9mcR2PXDlYjW/RsG6J8LgESaL+itQsevsfaimvD04VkJ3Ybh
	5CYIvOmgCYYIpiCeBaiGQOGOHGW3KDzvBGP4idvYt3Te0diIe6AtS02Wy3TkxSa+EEs77RdMfYT
	ldLvxEAoqUP82Ut9eWzwi+K7kEnDoGs89f3xeBnqIqr+Oce1AzLLGoOof88LBij2uJiX3YGDvp1
	uBdEvRizmbfveb4p4/DTScuDh+FJ0Nsg+Kb1giTPhK22k4bQjIX4zswwFHOsHTYMJqcTFm0zPbE
	BB06cO1pw==
X-Received: by 2002:a05:690c:f06:b0:798:3051:2f06 with SMTP id 00721157ae682-7988561d674mr73559807b3.53.1772310619559;
        Sat, 28 Feb 2026 12:30:19 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79876ac7505sm34314707b3.14.2026.02.28.12.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 12:30:18 -0800 (PST)
Date: Sat, 28 Feb 2026 15:30:18 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Kiran Kella <kiran.kella@broadcom.com>, 
 willemb@google.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 daniel.zahka@gmail.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 jayakrishnan.udayavarma@broadcom.com, 
 ajit.khaparde@broadcom.com, 
 akhilesh.samineni@broadcom.com
Message-ID: <willemdebruijn.kernel.c17952a3eaa4@gmail.com>
In-Reply-To: <20260228121034.48c2d282@kernel.org>
References: <20260226184654.3180648-1-kiran.kella@broadcom.com>
 <20260226184654.3180648-2-kiran.kella@broadcom.com>
 <20260228100449.19f6ef13@kernel.org>
 <willemdebruijn.kernel.1c3d7105f1c48@gmail.com>
 <20260228121034.48c2d282@kernel.org>
Subject: Re: [net-next, v3 1/2] psp: Support for transmit on logical device
 when the underlying transport device supports PSP.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262212-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,google.com,davemloft.net,gmail.com,redhat.com,lunn.ch,kernel.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21AE91C93F2
X-Rspamd-Action: no action

Jakub Kicinski wrote:
> On Sat, 28 Feb 2026 14:46:28 -0500 Willem de Bruijn wrote:
> > Jakub Kicinski wrote:
> > > On Thu, 26 Feb 2026 10:46:53 -0800 Kiran Kella wrote:  
> > > > This is achieved by propagating the psp_dev from the lower device
> > > > to the upper devices in the device stack via a netdevice notifier.
> > > > The lowest device owns the psp_dev pointer while the upper devices
> > > > just borrow the pointer. When the lower device is unlinked, the
> > > > borrowed pointer is cleared in the upper device.
> > > > Assumption being that psp_dev is set on the lowest device before
> > > > any upper devices are stacked on that lowest device.  
> > > 
> > > As I mentioned in the other thread I'd like to establish some clear
> > > expectation on where psd propagates automatically and where it doesn't.
> > > I don't want to see a stream of patches that say "fix propagating PSP
> > > onto X upper". And conversely report saying "PSP got propagated but
> > > it doesn't actually work" (macvlan in bridge mode etc).
> > > 
> > > Hence my preference was to require the user who created the device
> > > to propagate PSP. Willem, WDYT?  
> > 
> > Can you give a bit more detail what you have in mind?
> > 
> > An explicit user (netlink) API to associate a psp_dev with a
> > net_device?
> 
> Yes:
> https://lore.kernel.org/all/20260224002410.1553838-7-weibunny@fb.com/

I see. Yes, fair to ask for an explicit sensible policy.

It would be nice if PSP could transparently be enabled on upper
devices, similar to dev->features.

But this quickly runs into practical questions like when and how can a
bonding device with multiple independent lower devices support PSP?

dev->features also has type specific carve-outs for upper types, such
as vlan_features and hw_enc_features. We probably don't want to
introduce the same for PSP.

