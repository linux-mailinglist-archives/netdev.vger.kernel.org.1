Return-Path: <netdev+bounces-293086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE3xJS9vGWqNwggAu9opvQ
	(envelope-from <netdev+bounces-293086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:49:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1178360113C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 103C93023E1D
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 10:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0B33C8708;
	Fri, 29 May 2026 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpdAWPvL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF99D3B83FB
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051453; cv=none; b=i4gEhTdcb+TH+AyEk4CDxM7tnAze1nM7k6nT2OK3+cLq5cuuJHXD5AohKB7sKjBZqaJ+dRx3aCQXtg+k9wZUmcbWCrdUy0lOxvceDP59lPABOV6kipoT3h9FvgfYef4V1HfChN2+yl6x0Va2ebLg5m9TBzB6sudR0GBfdYZvTvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051453; c=relaxed/simple;
	bh=I5S8k/JMKwGUwSZMT68XJfAURo2N9wKPHUe4tpEhYjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQoQ0vmuFLHqbYA8KLMZYCZgtoge+oLSoemCWRYyM5xqcK6zv2mB6vvlXfTkyGsxYEGpF03VT8dq0+Fi0WlNe/z+C12Ci1u04tQLJW2hsYLAQEvgMCoV/hNW36ZI7157GiA23Re3YoFJUW9lwvE7hN0C45EnQYd29GfC1DLZrDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpdAWPvL; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-83945063f70so6640650b3a.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 03:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780051451; x=1780656251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEo/wAF2Vg4x050FkAPkUeP1qeuJRwK4JVX4fGCPq9o=;
        b=jpdAWPvLXL/6AnocOgYKW9yHV6WwPO4S6Qe4PbHduN8q+13NGQdbe3QxqhfGaz1wHp
         ePZhwWzaYyY97KEi8jWiO9O0k+h+QY9E3Plvt4v1HsWdcbYDiZdJbJgs5pIusLjuSQXe
         vF0XqIi39Yzo3ehga8niAMLv1sMQmaOfTJcr9vjLkLuiFJ3ovR07ifEOrhmaBwaAowV5
         Z8toqXAC08NbV+Ea88z12IKX494x/BV5lfc1Kc4W5o5iMR6mfSfZnA5EsdM8UX4KuAxF
         iFuKCF1gKT1p+XCbRRmKtHOT6dIdboS9eydTfO2XRjqkVIkQvhNucEG9PjMGAtKfofFI
         oGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780051451; x=1780656251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dEo/wAF2Vg4x050FkAPkUeP1qeuJRwK4JVX4fGCPq9o=;
        b=o5OQ3lzyA0zz76QUoOimYgZEVxmROrHjXaYJBzeEdDxc6jJqAcfJEvIDuzyGY7Vs1h
         U1WvG3pRmFnaF3gFejtJX3QEaDl3BjMpCzmDhfDG5udUoF2tYf6SzbHZjZ2nhiZh3SMm
         +rHZMxTjL5TpkiS3BwJ1J11tb0xDtRYTkc8X8T1H+7TTKfGTtu6BvZU69zLXO72YrSNf
         2azvRbYNdVITgz6g88UT0R/aAkW2Ps5O3AKWVztWnW5eXrHAmwt0M2QOneYQ/+dsvGEf
         NCBj0uico3uSgGFRetxzOEsySfSKcUxPI/EvyA/fwhicq2zvii61/b9+rVY4BIXNC7Lp
         5QQA==
X-Forwarded-Encrypted: i=1; AFNElJ+fKF4AgvX5cNccj24KC3C1TMN46Ggc+qIm4981Vb9EmTyUtRdYMIuuIPc18Kk5ZYVkEp3Xmss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9GeeVyOx3XtiunSX/iikipWI0UthCmMP8lJZU3fYLcW1OpabV
	gD+wSddCGDQFVxEMN1pnUX52ZbGEaTIti9WVY3eunrqo7aqRFtTQDCAA
X-Gm-Gg: Acq92OH4Vgjp4RRZ2SSeQBkLXp0vU3GBXLL9N5HvR+wu54Iw710jNjUSiz0LMeBchsg
	/4L++9kVRHf+cN+K3d12+tFF3FeufPw3R3Dvh1tH25xpnyM3juNqa24wHwHzyhZijMC/NfvdAjH
	k6wL3K4HQFSZikm983tnU0Lqs3wUBCsBWmj80BK0IDpovYjpVFs0fl+n+Go9j9+v/WG7cbCA1NA
	owRXddFKY07ds1RxWYF1VctaWp6ElivmNnvE5paGm8akJiHwwX1Gedv7nBF8TnajxZpTpDTGlMP
	Yu3vJJ8oDkvvLfxzCoicrdIouY7sT+6acQZiU8NVOZTAVcc2UAT5TbMQ80CTbG26Ke8Ht6lrxSF
	/C65D4jn84j6aQTSM0hPAtFZIkILR9IcDhFTZMJwm63rsCXO9YBtS0kT3VSrNpw960VUJV7LgFl
	xece9HtLDwoQN32c7VF9UreuVXLDpvOwqYbNwL22ATzqwbBVxanTT1r+I=
X-Received: by 2002:a05:6a00:2905:b0:838:5145:c1c5 with SMTP id d2e1a72fcca58-84210b3b262mr2263498b3a.21.1780051451262;
        Fri, 29 May 2026 03:44:11 -0700 (PDT)
Received: from teatimelab.tailcd024.ts.net ([192.129.190.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8421bfec5cbsm335418b3a.41.2026.05.29.03.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:44:10 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: fw@strlen.de
Cc: jiayuan.chen@linux.dev,
	pablo@netfilter.org,
	netfilter-devel@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	horms@kernel.org,
	lyutoon@gmail.com,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH net] ipv4: validate ip_forward_options() option fields against skb tail
Date: Fri, 29 May 2026 18:43:56 +0800
Message-ID: <20260529104356.911666-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ahlfI38aDciPfG2S@strlen.de>
References: <ahlfI38aDciPfG2S@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,netfilter.org,vger.kernel.org,davemloft.net,kernel.org,redhat.com,google.com,nvidia.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-293086-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1178360113C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Florian Westphal <fw@strlen.de> wrote:
> I'm not sure netfilter is the only facility that can munge data this
> way nowadays.  The plan is to disable arbitrary network header rewrites:
>
> https://lore.kernel.org/netfilter-devel/20260527121147.22076-1-fw@strlen.de/

Agreed, the source side is the better place for this on mainline.

I went looking for other ways into the window between option compile
(ip_rcv_options() in ip_rcv_finish_core, after PREROUTING) and
ip_forward_options(), and only found nft_payload and nfqueue at the
FORWARD hook. tc/cls-act run before compile (ingress) or after
ip_forward_options (egress), BPF at the netfilter hook can't write the
packet (base helpers only, no bpf_skb_store_bytes), and the LWT_IN BPF
path is blocked by the verifier. So your two-part restriction closes the
only in-tree triggers I could find.

This is just one consumer of the pattern; __ip_options_echo(),
ipmr_cache_report() and the CIPSO/CALIPSO netlbl_skbuff_getattr() path
are the same, posted as a series here:

  https://lore.kernel.org/netdev/20260524041442.2432071-1-tpluszz77@gmail.com/

so if the source-side restriction is the way to go it probably makes
more sense to drop these consumer-side checks than to fix each site.
Your call.

Thanks,
Qi

