Return-Path: <netdev+bounces-280136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPv+AiuD52mR9gEAu9opvQ
	(envelope-from <netdev+bounces-280136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:01:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DC343BB06
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 882903016B19
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ED53D7D64;
	Tue, 21 Apr 2026 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Po0eli1Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC16E2417D9
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779896; cv=none; b=stx7LH9RBFx8hAxCidd9uJa2v3cJZfUxvK4tdxvc6/wWtXAoOcQ+n/HICYN/D2Y54xliVqGyCe53iEdUjkVvtpCKuTfuVH9PZSmyYr17qMExPo1fSGsNASA9An77XlxDq7MlRQEwNhkc7vPbEAETACL3VWvHNxbgi4VEn+Ko7Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779896; c=relaxed/simple;
	bh=BMsJE9EnDz1dOWWyPQM3k+RSfXE5UE2l/a3GpM8Q06s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QsKoaEL6RFBSv/ivXT0VG7qbAkH3j199/t6lPTaIRzwgLvqgDneSNzPK6L7zNSq4mbSOieQ09YWrgv8znvsWJwf6xUKucJEjetqxagTY41zpm2igs1sAslEt/DkJRZiYEA89vglTqzurpF+UKt9XEeXH9+H9HMuGTwhefcPfuzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Po0eli1Z; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-67c250805ccso1426497eaf.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 06:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776779894; x=1777384694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1iVx5/UZ3SsrU7eWPB+6fTZTClt2QGPhXtgRoebaHI=;
        b=Po0eli1ZoAAUXEn/Tl12PVA687zC5svm9F4SFR1A0KP09/Jn1NOYvoYFNAGqjaiDpD
         fhv+8A3nwZWjGiKPFIWsacO0Yr2nlnCgynKy5jjzQ4NsBWmR/GB+fJp+Kvma2eLIwfjb
         1wEQuOq64SEm/N8dIvUhvzxGhS672m+zrLqTRmcZiMBvTBNqnFRsyPqe+k/jICftI+25
         Y8FWLqEg8t+GgkjVf7H1lWb2gLugfxP5rJgPmtZd+4cGZWf2ZIkaJMWrOTGwB4a6DpAu
         Cg32HOPWzD4LKxcuG77kbH/nIEf6l8rqOoVJPTHaqcR6lKMNugHs0iKXkvF1A2vlIkEn
         bVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779894; x=1777384694;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g1iVx5/UZ3SsrU7eWPB+6fTZTClt2QGPhXtgRoebaHI=;
        b=eJRN4VhOFOxM1Q563WIByagrJFD1Mo5ChFx5088JYdbSbjZ6p2QE3Cgi4Oljiq/Q2U
         vpGeXFI3Vbt0VACW6beiMmZVedtbCBF90rMq0HXzdYl0TKfEcqD6FU6AylDOxDiUsZz2
         EnMZSGlKs9SdeVisOdSdZpMTrQeTEdT3y1u1bUwhTJRle/HIxm/0450UV5aSe/2nUTX2
         pBtVIF6gzONXVwZGtZpA9QiH4uPyHgca4xQGZmVs0KMJL6DCDLwAF10J96/aD2lgd+M0
         MRlMLe19S2iPiDj4N9dVXgcqog9duHZ30+IiimjKO/qWlfWg1uxfZTUpK4nor1PEVWKO
         Qchw==
X-Gm-Message-State: AOJu0YyBe3oNYSD4plDhuiTyv8tnLqB/6NuTf56TfAauOQqWyoE0qVdr
	UurnO4uHhuqf4D2tFocJCn4cQ+ATtY54mW6fBgFdecOEPmIJhj7ZFN/4S6aA5jF7K5M=
X-Gm-Gg: AeBDietwzCrgwgBpkNPUEZ+sotRrgyKonhcdjVfogIWXm4CrVcgZeqHl9Rp3TPXzl/P
	/KtIptNthH9KVMNl2FTU5rsfPsbFXq/y2ZqJFSu4acb8BQVpLaY2LHzYVerNhlVpp9GeyYWhsBf
	Mvl/EFgKuqBT/2xEV5AohIZKakfqWMo1kKfAaotIRZixLKRTl+EmVG1vhoVQ4Ss11GpW3Ago6Dv
	O/bmoWrB0oc2nMEq64A499NJAUw2an5dwr+wFIMNXKJX7Jh0PhicRNx/DOGPGnVZBOt1EPC0FXV
	rFEEdCbKfnJX9FJ5Bv2SV7+/7zpGpLvHiCu4fmoyo3ev8NMOFwRcKwU+u4sdSVApxq8ObF8fkJi
	EvMGh/8D/0Nt7rvcU3c5MxwQNOwsOKNIVYfUcDxj76sACqm3Ah16FoGZSUAVkp5O+irvYoAFq88
	Wti9kPndoUfH7IUmPvTFI3m+YxQhZGrDUITlZYmcjuzepwFH7fyrLTFVrwhZKLtd2VpNOof3q/Y
	ULTbmgDwTD/OlY=
X-Received: by 2002:a05:6820:f011:b0:694:8bfa:7820 with SMTP id 006d021491bc7-6948bfa7baamr3741323eaf.44.1776779893990;
        Tue, 21 Apr 2026 06:58:13 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-694984114f5sm1229359eaf.7.2026.04.21.06.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:58:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org
In-Reply-To: <331f94663c3e8f021ffa3cb770ca2844a07d4855.1776760911.git.asml.silence@gmail.com>
References: <331f94663c3e8f021ffa3cb770ca2844a07d4855.1776760911.git.asml.silence@gmail.com>
Subject: Re: [PATCH 1/1] io_uring/zcrx: clear RQ headers on init
Message-Id: <177677989290.583761.17795174241839121036.b4-ty@b4>
Date: Tue, 21 Apr 2026 07:58:12 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[kernel-dk.20251104.gappssmtp.com:query timed out];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	TAGGED_FROM(0.00)[bounces-280136-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30DC343BB06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 21 Apr 2026 09:46:44 +0100, Pavel Begunkov wrote:
> It might be unexpected to users if the RQ head/tail after a ring
> creation are not zeroed, fix that.

Applied, thanks!

[1/1] io_uring/zcrx: clear RQ headers on init
      commit: 8138b7257581dee3da288c4f2a53ab603e05b1da

Best regards,
-- 
Jens Axboe




