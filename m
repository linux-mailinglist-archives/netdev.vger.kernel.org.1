Return-Path: <netdev+bounces-296090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dps6IhvmI2o30AEAu9opvQ
	(envelope-from <netdev+bounces-296090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 11:19:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3D164CFC9
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 11:19:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=VJ24xs9r;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296090-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296090-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F79C301DB91
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 09:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF82D30CDA2;
	Sat,  6 Jun 2026 09:19:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C092F361E
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 09:19:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780737560; cv=none; b=UqUsoirfTOXpglVs1R74Q7mIitF79VS/aJA2u1RyKKVnnewW9oVR5zrByokEIFKnQ+d6I/XgAmhTQ9Su1PwVkKkc46SHEIL32DOIn7dYHgtr/LAFzo4CryK6G05cIk/vI1E+gzbh3VQ6/75VmvaQWJIIlWCbYqvTpxav3JFwv8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780737560; c=relaxed/simple;
	bh=i0hUU1LR8FTs1GYt7XZtzOavAvG38zp6gVex4FUx7qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwZT/5mCG/xh1EY/h4nKl2Je3+ZPXPl18vrvyqPaB7/N/cNP4Rc/IDJLNtsWG5ecJ1UILRrV2IS0drq+CbHG59dgzHpYYiboVqLQyiaxepPIvG8725LWonbrzs7LGiJg2l6YTzj5klJP2GEn7X6Akd5w3QCezW704zLsmmG1j3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VJ24xs9r; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490af320e2aso30630155e9.2
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 02:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780737558; x=1781342358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ADsY3VhcNaw2SJvXvxwxYC+avdiz5am5e2nVPliaeIE=;
        b=VJ24xs9rxLS91qhd7trXJOBUe0mNxRp7q3lWfqtTtbq+U0CulKyFCiHutPpcDkqw5S
         8SUMM2zDn/DSz4QYF35mgl65506COQGGBOpC7w1WPWKBSR/hLN2uHap301iKNdGeaYst
         UEYQAuO8LgF0ka5cRfHie5DmGtC+acsRdRGWSKYAV/vyD3n9ID9n6IxzHECBqfvNLnaP
         awYLwkPgRfrN2gYSabVAgMTRRWKdMYs/UE4XVpFCBtLUrwuW76VLnkKPgGsWwuaM2DG/
         8cs0OeGqB/K7tE8+f/8jlOL00v6RKCuuZ1tMhVain8wOHhi3vnQLXdDnxuSvOvnUy+42
         f+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780737558; x=1781342358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADsY3VhcNaw2SJvXvxwxYC+avdiz5am5e2nVPliaeIE=;
        b=CjQln2iUGZLJ2WLkQoJJ+3xWuojArE0R2qPUwhjj2fIQtp4zl3z0EwztxZOfVhR4qj
         yG0RKHF13h9fE8xhoF07W7DiuWVaLUrGq7thO2aiB4zXnosQcP6Of6vkRm2evLGIKVM2
         g2ZxamiVxzUuXAo9eYCbSOWQMLp+9lvy3xeWOLxU6pv7CVKq95aon0BC6CmILpo39Snn
         PapH+7ylf3q/nFuzpMDRLBziZWsCm91Sm1yHP5bg55VrKWv/fk1srVniIsJQdtijrFmI
         dXBm1K4+P3AptSyB8oLWYB7YPHolEtJ5H0u+v/kokSKWD4c+8kpCUJbBj9CTYpZVSbYD
         CnTg==
X-Forwarded-Encrypted: i=1; AFNElJ8Kp6FN/nhUWbJQjejvbI8D6lSwfAZUcxBBixi0q+Ig9REjbsHiyn3Lo+KH3Tk802clcNJMZuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz7/QtgEn4ptTMS7lNvwzQixOiGPA6CDlvp+v9wl6qHMbmMwp6
	slF1mhxca7/zbpXc6DM6pro68qRuJm5xhY8Uo23Lh8fi5P4op6IC4rujeaxZDMaJoZc=
X-Gm-Gg: Acq92OHDe7R7rP72Bp/d/dg9poARzX3X7/0HFpUrWnH+6Hu3KgUBrkJZhkQPXK9vHn3
	pbv86gL0x/cfI4iLoKes9+yjEaArhtUbj7jgG6cbbN5vlmHGDbK5IwhTxQBHFQ85qcqhOrmFAVr
	/xf11sxZv5JIVPNchHVEFSd0al7DvjUuFTobtP9+ZncpO3FJQlJcNC8Zc4OBMFufVgsyGdVzaWZ
	6qF5pJ1ixN226XVnzVrce9fO3EZcLF/39rAfuY/7psxfWIDCkIK7yzKtSrFW+hqbPJYfj8c7zV5
	6Od7f+GBMu9NVEr+mcF+QIGtfONLE3NCkmw+omAnvWstx6xO6X/xVl8SH2RZEt+ViyJjJd6omPr
	C3Arr2N6+QkoVtU4resC3bejN29sE5QSFUa5IxYvGXHTybk/FofdDhk4/foqr+8anl+wtxqaglv
	pwfGr0to4s7DXKvvxFtMO06zdYuXioDc5HYPH3e2WJRHmBdnCYvrJk203Ub0hn7lQ=
X-Received: by 2002:a05:600c:6384:b0:490:acb8:1490 with SMTP id 5b1f17b1804b1-490c2591e5cmr115838775e9.4.1780737557839;
        Sat, 06 Jun 2026 02:19:17 -0700 (PDT)
Received: from u94a (218-164-53-75.dynamic-ip.hinet.net. [218.164.53.75])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d2bbsm124256335ad.1.2026.06.06.02.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 02:19:16 -0700 (PDT)
Date: Sat, 6 Jun 2026 17:19:04 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: stable@vger.kernel.org, Paul Chaignon <paul.chaignon@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, 
	tamird@kernel.org, eddyz87@gmail.com
Subject: Re: [RFC PATCH 6.1.y 0/2] bpf: backport scalar not-equal tracking
 fixes
Message-ID: <aiPlO4a8QnMFBqc2@u94a>
References: <20260601180400.1381736-1-jt26wzz@gmail.com>
 <ah5pf25fhVH9WuU-@u94a>
 <ah56iBM2P_9hF3_L@u94a>
 <ah6dLESn8tHAtxS9@u94a>
 <CALgi0X=qjiB756FnrYowor26sybA4z2jNCPrjieGcAA52KJS1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALgi0X=qjiB756FnrYowor26sybA4z2jNCPrjieGcAA52KJS1w@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296090-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[shung-hsi.yu@suse.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:jt26wzz@gmail.com,m:stable@vger.kernel.org,m:paul.chaignon@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:menglong8.dong@gmail.com,m:tamird@kernel.org,m:eddyz87@gmail.com,m:paulchaignon@gmail.com,m:johnfastabend@gmail.com,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,u94a:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF3D164CFC9

Just want to send out a quick reply after looking at this.

On Wed, Jun 03, 2026 at 01:25:15AM +0800, Zhenzhong Wu wrote:
> Hi Shung-Hsi,
...
> I ran the suggested checks with the same reproducer, where BAD means the
> program ran and observed the unexpected error, and GOOD means no error was
> observed:
> 
> - latest 6.6.y, v6.6.142 (924b4a879cbb): BAD
> - bpf-next at b93c55b4932d: GOOD
> - bpf-next with the d028f87517d6 JNE refinement reverted: still GOOD
> 
> So the issue still reproduces on the latest 6.6.y, but d028f87517d6 alone
> does not explain why bpf-next passes. I'll do more narrowing and update the
> candidate backport set accordingly.
...

I think it possibly comes down to commit 4bf79f9be434e ("bpf: Track
equal scalars history on per-instruction level") added in v6.12. Without
that, the precise mark wasn't propogated (for scalars with the same ID),
and that likely made the state comparison (invalidly) go through.

Shung-Hsi

