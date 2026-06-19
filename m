Return-Path: <netdev+bounces-300596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E9/nDl3TNGqMhwYAu9opvQ
	(envelope-from <netdev+bounces-300596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 07:27:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FC26A3F19
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 07:27:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="p8ZfD/P8";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300596-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300596-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3767F3032060
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 05:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5888328635;
	Fri, 19 Jun 2026 05:27:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E652315D33
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 05:27:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781846874; cv=none; b=mOp5h9E2LW69CTiV5vihgfWrpwTqMa0fbrBq5m91pqhQy9HJQcakUQMSy490H+elImUGpbt8tksAwwEnIN7bzPF/If6BSnHYpcIDioNF3vWTi6Leq//9AMdyKB9MHKWRxrBo7aIEZuq78A9JOahGime6e86L1+zGhcs4lW7NTPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781846874; c=relaxed/simple;
	bh=1xYUQuEJGMisyUSD8yUCi+h0r0/aFvN7+YM/tQTSNF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dD67nwTgHdd9pCQWLwVuGCAW1ckDkJ9t8kwxocucsFQWl4KfIRKRX/92aRcuG+NxIKV7bHYgbLn7SfDMVXTFD2lZokqY/oHaE2rt46JrFq8iJwgNkXS+YBWMZmMOk087gGKt14V8p+GQuHmhGS1GHja+s7blZJZxkSRDye4DOvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p8ZfD/P8; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84232e83ca9so746866b3a.2
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 22:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781846873; x=1782451673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jT5ucJxS3AylJogy+VJoQXNUQw9OyolCVtNHaI3XYUY=;
        b=p8ZfD/P89scY7aHF3DDmt4188opoU/bj2m0cZ7nztD73fcmuS4mFyANacI+++wBTV7
         fvmXhNA7ki9tbxXIceT3H1ICYOOUW/l3LlivOFGQH6Nq8fNC8pusEAcMk61GRRONsUDB
         owYEb7Y88JNQ8cQax12csfRm+VIPnZV9OSNthOT61Xt6w5aW0mvNoEqgbZ4V3ssLGGuE
         is9XTCKwKp+mihMfeHbAoEPGCo0E+QfsbehwFgjn2IJXVhz77BVExrKQA6j8DXojVK2B
         Q+yZiLq3Ebwzy2QQdgqXwC2SmFGW0xMZrlrDaCh+CEpEPFUwVdmuV0pUgkh7opVuV9Xb
         D+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781846873; x=1782451673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jT5ucJxS3AylJogy+VJoQXNUQw9OyolCVtNHaI3XYUY=;
        b=f7budK//yXQs2Fpr+YJuxE28QSEMuEgGu5kvhsNkIvWPeDy/H1JBAX6GkrW01b5Yff
         nys9HRxFEdXjQd6bIEFxVzOeY0cXBEXnD4b2fIG8ZpvLLBLSNmweP4g4d7PCxUyZbWUs
         OgecLcwbnxMRz0YsLVCBDeeN7MNpgYLbZEyvJdknOZ6tx6E1Uivnm3j01KWTGWBHEa1G
         qgI6y+btoE4v6COvhTevVyawXOxvgVW23/q+WGJB8CFoNtmbm307tP/f9id56BW6OgUu
         31vdsBsEOBiKofMDSMycV8F98KC1ZvYU02swTIWrO19FKIizLRpveJ+PHmTaSECFa15t
         GmbA==
X-Forwarded-Encrypted: i=1; AFNElJ9e7++zo4SNuYnNoTJs2mDu/5A359L3q+AKCjdGAcTTtG6MjRpzlvixGXoZahIUXpyjvsa8jlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9QSdNLfLh2gH+zr+Fi7/x1/AexaGtoNFIq5thpHqaiyFWzlw9
	18aYY4rA/cs/HgwJ8IaLSh4D7utXTG0jrLUA/zBAytsu/Uii4aRjkJm6
X-Gm-Gg: AfdE7cmlLYSZyScIbBe7c8CTS86Km8A9cQLR+aVrX3cloQBNgvPWbycvkfABBTKWnKH
	3mKO2vQLc07zLKH3V3x/pmbktAdV+BSvPaBcG+aGCqK6f0OuNXRDkS5kBuh0KeFFMF6FCH1p69k
	BhGxO4/bzIjQMEb3h2XUKN+0ntn1B0kZzzYv8vzcjWJLjYqu5ieaXAigBdFk3g51eC65uqGqw7B
	yJAeteCmQPKWVPeeSFgIiMod33PCWskLRZ0pvoHKksJjFJWyGn/jhiUytoi6k2rTKHTo4cZVUME
	neHRBlUdbR49oaGaT5mcryFuO1EvjXYDAQGGb/Vpy40D+nbLy/UrUYalAtEDsBK/TGTZIx+k8XF
	G3+0MstriZtfZSWUC5a9RjQX9sP+DsQUYnbo3ZFihWmeCiRujzrZOL+FyyFym1SILWwrW4kkXHH
	TioaKSFg==
X-Received: by 2002:a05:6a00:8d8d:b0:841:d0c0:d9dc with SMTP id d2e1a72fcca58-8455619dc41mr1133217b3a.44.1781846872511;
        Thu, 18 Jun 2026 22:27:52 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84553858d22sm1163644b3a.55.2026.06.18.22.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 22:27:51 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
To: andrea@common-net.org
Cc: Yuya Kusakabe <yuya.kusakabe@gmail.com>,
	andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@gmail.com,
	shuah@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	stefano.salsano@uniroma2.it,
	ahabdels@cisco.com
Subject: Re: [PATCH v2 4/7] seg6: add End.M.GTP6.D behavior
Date: Fri, 19 Jun 2026 14:27:39 +0900
Message-ID: <20260612032313.24062-03-yuya.kusakabe@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260607020517.0c6bbb8beba505ac9447545e@common-net.org>
References: <20260607020517.0c6bbb8beba505ac9447545e@common-net.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-300596-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrea@common-net.org,m:yuya.kusakabe@gmail.com,m:andrea.mayer@uniroma2.it,m:davem@davemloft.net,m:edumazet@google.com,m:dsahern@kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:justin.iurman@gmail.com,m:shuah@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-doc@vger.kernel.org,m:stefano.salsano@uniroma2.it,m:ahabdels@cisco.com,m:yuyakusakabe@gmail.com,m:justiniurman@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,uniroma2.it,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,vger.kernel.org,cisco.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87FC26A3F19

Hi Andrea,

Thank you for the review. The points shared with patches 1-3 will be
addressed as described in those replies; below the
End.M.GTP6.D-specific ones.

> The "src" attribute is used verbatim here as the outer IPv6 source address,
> same as patch 3. The src dual-semantics overload flagged in the patch 3
> reply applies here too.

Covered in the patch 3 reply: with the End.M.GTP4.E template use
gone, verbatim outer IPv6 SA becomes the single meaning of the src
attribute for the IPv6-emitting behaviors.

> Thank you for the follow-up in the cover letter thread. The finish callback
> writes orig_dst into SRH[0] and Args.Mob.Session into SRH[1]. As far as I
> can see, this matches neither Section 6.3 (Args.Mob.Session in SRH[0], no
> D) nor Section 6.4 (D in SRH[0], no Args.Mob).

Confirmed, that is the bug from my May 10 note. The next version of
End.M.GTP6.D will push the configured SR Policy verbatim and stamp
Args.Mob.Session into SRH[0] (at the locator length given by the
explicit sr_prefix_len attribute) per Section 6.3 S08; preserving the
original outer DA in a prepended slot will be exclusive to
End.M.GTP6.D.Di.

> Same reverse Christmas tree as patch 2; same issue in the other functions
> introduced by this patch.
> gtp is only used as a cast intermediary. Could it be inlined?

Will fix both.

> Nit: gtphl and hdrlen are assigned before the GTP1_F_EXTHDR check. On the
> path where the E flag is not set, gtphl is unused. Moving the gtphl
> assignment after the check would make the flow clearer.

Will move the gtphl dereference after the check; the pull has to stay
before it, since the long header is also consumed for S/PN-only
flags.

> Maybe ext could be renamed to ext_hdr? It would be easier to distinguish
> from ext_units and ext_bytes.
> ext_units is only used to derive ext_bytes. A single ext_len would
> remove the intermediate variable.

Will do both.

> If the extension chain contains more than one PDU Session Container, *qfi
> is silently overwritten. Is that intentional, or should the function reject
> a duplicate?

Not intentional; will reject a duplicate PDU Session Container as
malformed, with a selftest case for it.

> ext[ext_bytes - 1] reads the Next Extension Header Type field from the last
> byte of the current extension. Would a short comment help the reader?

Will add one.

> input_action_end_m_gtp6_d() does not change skb_dst(skb) before this call,
> so dst and lwtstate are the same ones the caller already dereferenced. When
> can this NULL check trigger?

It cannot: for a route installed with LWTUNNEL_STATE_INPUT_REDIRECT,
lwtunnel_set_redirect() always populates orig_input before dst.input
is replaced. I will drop the checks and call orig_input directly.

> Same dst/lwtstate issue as patch 2. Not introduced by this patch.
> Same missing iptunnel_handle_offloads() as patch 2.

The NF_HOOK split goes away per the cover letter thread, and the SRv6
push will go through a shared helper that calls
iptunnel_handle_offloads(skb, SKB_GSO_IPXIP6) before
seg6_do_srh_encap().

> Same BAD_INNER misuse as patch 2. seg6_do_srh_encap() can also fail from
> seg6_push_hmac(), which is an HMAC error on the new SRH, not an inner-T-PDU
> problem.
[...]
> segments[0], segments[1], saddr, and daddr are written after
> seg6_do_srh_encap() already called skb_postpush_rcsum(). skb->csum can
> be stale. Same for any later change to the outer header or SRH.
>
> HMAC, if configured, is computed on non-final SRH and saddr, hence invalid.

Thanks, both of these are real issues. My plan for the next version:

- every field stamped after seg6_do_srh_encap() (Args.Mob.Session, the
  preserved DA in the drop-in variant, the outer saddr/daddr refresh,
  and the dsfield propagation in H.M.GTP4.D) will go through a small
  helper that applies the corresponding diff to skb->csum when the skb
  is CHECKSUM_COMPLETE;

- the D-side behaviors will reject an HMAC-flagged SRH template at
  configuration time: stamping the per-packet fields after
  seg6_do_srh_encap() has signed the SRH would always invalidate the
  HMAC. Inbound HMAC validation is unaffected. Would you prefer the
  stamp-before-sign ordering solved from the start instead?

> The initializer on reason is dead. Every goto drop path sets reason
> explicitly before the jump. The variable can be left uninitialized here.

This goes away with the drop-reason rework: the MUP drop reasons will
be out of the initial series per the prep series plan, so the variable
itself is removed.

> Same SRH validation concerns as patch 1. HMAC is not validated here.

The ingress will use the same three-state SRH helper as the other
behaviors, which validates the HMAC whenever an SRH is present.

> Limitation note for both input_action_end() calls above: correct per RFC
> 9433 Section 6.3 S10-S11, but the SRH is absent or SL == 0 here, so
> input_action_end() will always drop without signaling non-GTP-U traffic.
> Perhaps you meant to drop directly with BAD_GTPU?

Right, the End fallback could only ever drop here. Instead of
dropping, I plan to hand non-UDP, non-GTP-U and non-T-PDU packets to
the route's original input path (the orig_input saved by the lwtunnel
input redirect), so a downstream owner of the GTP-U control plane
still receives e.g. Echo Request; the selftests will cover that
passthrough.

> Nit: inner_first could be an inner_ver with the shift done at assignment.
> The name would say what the variable holds.
[...]
> Same repeated size-selection ternary as patch 2.

Will do both: the inner version, header length and protocol computed
once in the switch.

> The anonymous { } block scopes three variables that should be declared at
> function top. Splitting into smaller helpers would make this easier to
> follow.

Will split the dispatch and outer strip into a decap helper shared
with End.M.GTP6.D.Di, with declarations at function top.

> Same missing frag_off check as patch 2.

Will add.

> The "{,.Di}" shell brace notation is unusual. Emitting the actual
> behavior name (End.M.GTP6.D or End.M.GTP6.D.Di) would be clearer.
> Same applies wherever this notation appears in the patchset.

Will replace it with the concrete behavior name everywhere.

Thanks,
Yuya

