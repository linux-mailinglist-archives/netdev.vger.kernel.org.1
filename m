Return-Path: <netdev+bounces-263028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OMcA75Xpmk2OQAAu9opvQ
	(envelope-from <netdev+bounces-263028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:38:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 122701E883C
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AE5A308833B
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 03:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064C737CD53;
	Tue,  3 Mar 2026 03:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGM+GQgi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D3B35E93D
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 03:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772509073; cv=none; b=JnzaY12AOHIundBvyqG0owHSv59P+DMRgRmcyIr8e+wxnx+xShFoYfzVSJUtmngJK0kMR8puHMI8fxqN+1SuNgTa5OhFVsdfA3MN1GoaH1D36v4zwETXWG1ZFn2bIjm+An/wYLBbLbqjvXxGuku6ckcfr+IQ+gaBlucQQyhn4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772509073; c=relaxed/simple;
	bh=ti+F8gi46xGdX9LBLfoqgRNGde048rXCFzZQnl9YDnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ox/KtXM0BJ23FmWHDIWdugDPgolOzoMaKc/TtE6iFQpas70oK4R4Lx8jWAr7e+r/4WKHwrmKzLYUrdVcT+7OrzOe+SkH88JwiSiHyMrwC+INSOkThHlsIeZORlr3oeWy6z6FUGEOltIkfCLCcXJjEhNvRdi1SC/8nkgkBxUb3S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGM+GQgi; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8273e0fb87aso2788333b3a.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 19:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772509072; x=1773113872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7VLgLYUsL/uRRIdiq+OpOVCTafl9uDLlA5ann5kAl+U=;
        b=gGM+GQgiHOV8jYQgqULVz4gjkVGfdH0T4SI/4i4vZKKXMJTmHb1++XfERx6QlZOtz2
         HyUw766406wlPd1HO96QApVKdz2F4vuzgJLecdTz3GytYvd8BqyEj+Ga62dmBege8tcb
         h30Up0Ib+IFH0M7gvgdoIEdAuMdq3drjWNHaUE+UjMCELGlhQdy7pTWOMdL6hNsAMI4/
         VUbgHxkPSm/b6Q9opecFqVm3UEAbXb7gNDpoc3dOMPBwBed7k4CVwN9DXTyGeoJk5yHI
         4+oXvVg4b2ouTiTipnD4KBZ/jC6i6iWTqasos3tZRjyE1VZ6ZyXiy/eL0vEE/4iIt2wt
         rTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772509072; x=1773113872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VLgLYUsL/uRRIdiq+OpOVCTafl9uDLlA5ann5kAl+U=;
        b=NTHhsGsmPX+3bTZTWEhcpjSgjCWSvHFZAuaUyarcJdnMOKecMP5W4i1Lj9dW/RnG/P
         ILzDTGALt4XDSHJbtgUqT9F4VLHave9i7EwsctXDDzT0cUSsafKiB+cQkpJ58TeLTXaA
         pv46anHlcHII4GaBsfUAOL5JoLPKL9u0mov9irzIAyPehfZvXB5X+Oj4FnuqE5jiZSoG
         fdTMcyrFCXX9nxUTw0A23M8Wp3UzKk0R1Ue9T3hCuNz3BEdwj4EwVYD1fxuc1LkYvhdc
         XBDh2jQdKmc29g4pFaKDEt9/U9p3myolH1zmK4Q5MV1Cp2cd13gxkL9v+l2pfGmqB2qK
         MbCA==
X-Gm-Message-State: AOJu0YwQComf1U0rnRtjdNyTzWhjaEy1jdVIK/z+11FByQ6+ydq/sCEr
	XxLFzAAEcuPZWzBBk7xVi979t7TI+HQcKzUEJxnLoUYitSmRznsn4Tpr
X-Gm-Gg: ATEYQzxWK+I+tZtw6D8iH21I3F4Z7xiXkx8wawvcB+NFcZUsAEkdiPEuw34ZExRi7HU
	v9DCxkDXUOhBwvmd/14m6QYa84tFt0+RCzIY65jVYGx5ia+ASRmOv2fVZf3HsWjfviGJNHHAtmV
	jAYdYH4WPGlnl2Z7CV+t9TwoZJXx/Kymh+WgzhuxBbxkss1KeunkceUg7P79S8MTS0duIph128v
	Oe4GQ9TxaLaEBBXBj+vqN9BJA4tnWBAKARXxLXA13kPIsKtkhoBIpfBc/0Ho6DVyEuVnVHjEr1U
	pDcMILlilfQFiKTQTnmxOsYAC2z8gCSiEtbDIuPnQk3cTZV1YzojjkOqESxzsjJS9RCj6RrC6fw
	7sPmNGP9NrPQhq3dodxOGpUCh0SiMhHxbuRZMuoSd+16/OhRGBe3KpH6QddSWWAFuqoMznXWZ3Q
	W8r35oW+7Jw3jK+r2sIV7MzE5A8iaVoIlccoNZXTOE9kDcbrOliIMUfrvXikAhNF+lHmxudQ==
X-Received: by 2002:a05:6a20:734c:b0:393:f002:ff63 with SMTP id adf61e73a8af0-395c3b03ed5mr14309867637.43.1772509071845;
        Mon, 02 Mar 2026 19:37:51 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff1ca9sm13896871b3a.36.2026.03.02.19.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 19:37:51 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next] mailmap: reflect my gmail as default
Date: Tue,  3 Mar 2026 11:37:20 +0800
Message-Id: <20260303033720.84108-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 122701E883C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-263028-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Jason Xing <kernelxing@tencent.com>

Use my gmail instead so that I can easily handle those emails
that CC me.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
Jakub, Paolo, can you take this patch in the network tree? Thanks.
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index e1cf6bb85d33..412819ecb14c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -348,6 +348,7 @@ Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@opinsys.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@mellanox.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@nvidia.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgunthorpe@obsidianresearch.com>
+Jason Xing <kerneljasonxing@gmail.com>  <kernelxing@tencent.com>
 <javier@osg.samsung.com> <javier.martinez@collabora.co.uk>
 Javi Merino <javi.merino@kernel.org> <javi.merino@arm.com>
 Jayachandran C <c.jayachandran@gmail.com> <jayachandranc@netlogicmicro.com>
-- 
2.43.5


