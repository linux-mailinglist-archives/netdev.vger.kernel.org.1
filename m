Return-Path: <netdev+bounces-259338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFRMEYP6lWknXwIAu9opvQ
	(envelope-from <netdev+bounces-259338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 18:44:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E1D158671
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 18:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B09D30058CB
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 17:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35682343D74;
	Wed, 18 Feb 2026 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="r6NLG9hz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7299B345731
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771436673; cv=none; b=O2rzfAAVmpsZWgtzRXy7lVb5kwMsMfoMjX4BP6x+4lkgdQlqDBKKAhLnK/zIlqe5ilGb/XMoZuwjANFYV+Kj0xD0sYWk1q4c1XnTKHyTuFmKtoa41qJ+ewQ7nxOYO8hPDtli4gfKV5Bj/6ml835I1uKU1cZ31ehXJ0FFOPLC0cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771436673; c=relaxed/simple;
	bh=DAPjo5Vesdht9bmwlcZvfhdk4I6QmRF2Twzcn0AX36c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i57KicL4sKT9GD5ycn7UeKBaKJNw5m1jqDd2rsuJmgiPTTmEcyI2AFnOKbPxZ3bvqYslUULFNPgWL/0cmY5F2hfbk1RzmWPe2ahkA/GObmjCRlwKPq0tATA+xRoOWKa9f9y3LFuqzDiOVlQACE+mSBSIdalRYnj+GklSq24P1Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=r6NLG9hz; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb513e860cso5100885a.2
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 09:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771436670; x=1772041470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f52Wwd+rDLXDwPRRIQsN1Yx7eFsotz+Oj4co4oyfPt0=;
        b=r6NLG9hzAvoVeSWlXgZGbw+lN8td1J+RDI8qk2USRLFr61sKh7xRAhF/Ooza+b2EYQ
         R1OKBSt0jZVYvSviWOYKbNudYJG/yTngumbRrpN9w8xMPc+efonOWASOpyawZMDuPrjP
         wFul2msURiZxQSD7p7KR6YfmF4QX/jFe9bZgYeblsEM/ur1J8TyvHpWlxoQ5Ps2blUBc
         hYHYtWsuJnzJPeWcVsUUrH2kam3r/cwzjzq9xO1oh5BjGySVwZSFRCuwDw6Ukl7/mbAG
         04P9S0hnss1Nd8W5fTT9cRE5DMA0zAgsGiwIEvEFkR1VjpuHSA1gK+3DYbzP354zXrKV
         BagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771436670; x=1772041470;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f52Wwd+rDLXDwPRRIQsN1Yx7eFsotz+Oj4co4oyfPt0=;
        b=OT+KYckbovKaMzT2D4b1V0xWOX44IGQTXdVk97EFYjSwglQ9arX+feBWigy6Zjoqb3
         sq56jBQcmMQpErNRY7i1LL+2zvdqQEGVbxeC4fooDr/lp6X2Qp7Dho9xAY3NHZVLTKL8
         cFUXFebKdC/DNXDaI9FWKNTKpntOF6RhN5EjdKivUly4xE9QKr9HetKK9A7BVg7JyISJ
         Lq0jIR5FZn5MDIqOZKZRuOwM5KoENAj8AEUefaOd2kPjnGca8EciVKHKCFphEvPwH9X6
         KZ/bcXjOXW/AD4DCZ+V+qJJCAFHQpvYzUKNc3mvE6mRMWAv1tijkFdRUzzLsjZJjKHz+
         IwYQ==
X-Gm-Message-State: AOJu0YzufnSbChIau2ZMYWt+H9JU+1BqCEkSGX4eBUdHYgkAcyxekzjZ
	owW1YPNoQ4Fb8gzyevbon+suzUYohRNyOSMbYbxKFFj8G9TdysC3/AOZ4zKfssdQ6gYZHp0amWf
	WtNjth+M=
X-Gm-Gg: AZuq6aJ++Nkdi9KX/91JWXDN//wHPD0/pEx8pjg5Amm0+yR8JlIB6arVH80Um/mvkLx
	0xweO9hfpuJiOCv5YR2bVkC75Sd0fyOeBGSBE0L4dlayyFizbXP8ZemSExq7X8815HZCgUlE47j
	RGHp7VIOgHWZyJcfIpvB6rq5Vp3LM8Lazcslqccy35rmzkyN4H0c/qet5kpHUHw8lQUJRFiOrDe
	pvX+EseaPr7yFWb05d+swjFx6iXatHHu/CIDi9nKozCDXtg4yEft7T955swrIz+8bR2h0y8aG+E
	VbpydSUyfQ2e9rv8H8FndEd0793NTm7acchs0XJPlWmIWTSMKVyvg+fPDvrpSw1vf7V4zEgSeFl
	BSHZQje87fFgg6xmgNX2OenIV+b+KxCe+u+dlYhT25QjEsp9VtVnEcIClKRKGjWCB+LNPfEAuhO
	s72EkfIdbepjb1bKuBMDlatUNuTYBtIN38JnG8EXZJKmft
X-Received: by 2002:a05:620a:1712:b0:8b2:e666:70d with SMTP id af79cd13be357-8cb4242a53emr2221223485a.43.1771436670115;
        Wed, 18 Feb 2026 09:44:30 -0800 (PST)
Received: from [127.0.0.1] ([99.196.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0e12eesm1872969085a.15.2026.02.18.09.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 09:44:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, Kai Aizen <kai@snailsploit.com>
In-Reply-To: <364c2e7d4f53b26bb3133cfc4271183fcd450be2.1771435883.git.asml.silence@gmail.com>
References: <364c2e7d4f53b26bb3133cfc4271183fcd450be2.1771435883.git.asml.silence@gmail.com>
Subject: Re: [PATCH 1/1] io_uring/zcrx: fix user_ref race between scrub and
 refill paths
Message-Id: <177143666453.514340.3486576920762114601.b4-ty@kernel.dk>
Date: Wed, 18 Feb 2026 10:44:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259338-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kernel-dk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D6E1D158671
X-Rspamd-Action: no action


On Wed, 18 Feb 2026 17:36:41 +0000, Pavel Begunkov wrote:
> The io_zcrx_put_niov_uref() function uses a non-atomic
> check-then-decrement pattern (atomic_read followed by separate
> atomic_dec) to manipulate user_refs. This is serialized against other
> callers by rq_lock, but io_zcrx_scrub() modifies the same counter with
> atomic_xchg() WITHOUT holding rq_lock.
> 
> On SMP systems, the following race exists:
> 
> [...]

Applied, thanks!

[1/1] io_uring/zcrx: fix user_ref race between scrub and refill paths
      commit: 003049b1c4fb8aabb93febb7d1e49004f6ad653b

Best regards,
-- 
Jens Axboe




