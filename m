Return-Path: <netdev+bounces-268193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAAxFZsluGmNZgEAu9opvQ
	(envelope-from <netdev+bounces-268193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:45:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6464829CADB
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ABB830333A5
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445AA3A2567;
	Mon, 16 Mar 2026 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wpES5fiR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD16339FCA5
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675865; cv=none; b=dGwvY4OQyzUmUyh+cV2xI62RSwZp2w6UrGrqpNYdCBy3xe4mG5t7vfPDAjRHOeqXaa4rjMn4GQchSrJIYJ9UeUEjmEB20Qnpp/Z2utEJ+5zBqKvT01MIoS6iul4FDt0zaQqllHkB/bDPFHPXXR2dmo11WJPcIAlLrY3Kj1xCXCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675865; c=relaxed/simple;
	bh=eybOo6B9sJasoQ74Gj0ZF5izHMiA3bBhxNpy0uxQCi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMvGDn7pgr5LxrvNOcLWa2l5FfSCsWeMRy42jFhT16NVWojQKZ3xCoF+DZGX/dbdaCjqr4eeUGslVYt6irDykZW+UEpUHZt6q5rhRToMumZqZlldB1GVhBWfCIlnEqWjnD2m2K7AZoMibEYKeyex8H7Q4g/Y7p590C8rhptIPCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=wpES5fiR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4853aec185aso39217805e9.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 08:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773675860; x=1774280660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fLOeF+e8kNYqmqlhku8MC++OJVE4/Cg1v6eXd5OJpH8=;
        b=wpES5fiRZ08qTjqbk01GOE+B2uB9a+fW2/8LgRNTbaOqKEZvtkU9TyWR/WkzDX4IRe
         28C4fwVAQDo3oJT2jlZfv47JHncepC6TbezVO44QYqbCJZR5PVAmbdYpPwna2NrVpk4L
         HvnKKNmMjsF49JwMyQqtCo+T1KJ2+zcrRK6QwYQVYr7aIqe3N/FmAcvFiAsD4QN+hGvj
         P2D7gMsGMGqdL+LjB5L0JJ0+TSL2CXmH9UyFXYPgBOkNaXSrhnVxsyqvQEj8rUTZPz31
         WoD/t1nlkVliiI3HMETvrTGF3w/6ub1MZjX2ll1ZNckW65diNFGcfxjl2cBvvFDpVl7b
         SJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773675860; x=1774280660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLOeF+e8kNYqmqlhku8MC++OJVE4/Cg1v6eXd5OJpH8=;
        b=iYKGUz7j2urSK8YOjC+0A69HRTE3sLbXwP624PLeB2TaJ36+6ARBxBmHSBANbCmd+Y
         4k69/7WNoYYxMw8fnmlACwOIt+sasePNvL9sCdbeWoGEuLYFmS7ObXlriowICD+DRJ55
         nx9XaVap3/Q+jBnYjDm+E/DroMV+4QsJZBeQeMPxxIdJiARlASEun7zNtF612JY1zIKM
         h+KAPO61ZIyOeKQMMQLN9OQwRDLOEYx1LOOavYqYh8k2EmsFJIRbndsL4jpbplKy3tBG
         T5m2qJ0/OjC4itCTfOKKPxDiS/3jkf69t+KWznpQxtUYCJ3uC4lAzw08KKDyuUJkPZBq
         2fHA==
X-Gm-Message-State: AOJu0YzUHJe2jPBkyWzZ5mz5y0luNM8j0yqhuhcIDZ838kMRASITNdkg
	0DSrZdx//TiiAeni9nmHiZyiiYULqRrTbT7wIIg4IEyn3fOyZl1GrLzl4UoIf4LwChWSkCh81ck
	gp4NgK1Y=
X-Gm-Gg: ATEYQzy+Lp9QH9SzHiu45id7tujJosV3UmjbrxyzI2WRcwpERBkiZHdxg5Q0awwuHpB
	rc8QQlO2Zng2SQ9/2smpSz2C/Sc/CYDQBTOXRKwIQnhLkQ4CEHahaSBfyDtvXa4ZrbDyILBmpMX
	MM7OVFwWMzNCCrXtubxlhsKmQ7VERg+BgHtn2jd9X9xbI6mNHdQwCLH9TXEK0k0VYQTbcHa1SeT
	79zJrPf5Gb+m6z7fs8BktAvJVFTbOtJ2v70F/Ke+z69CZ0F4OmCWXfiw3zuE51k/l97i3AoJ06x
	GPsUuwRWFI0Lxgul5RDQJt3qephnoV85RYlILo0w/gBddWgysO4pGX7OFI3D7B3gTIoKwEhwsTr
	fMmQrHj3mzK4f1/2JLWPSa3gtoSgnrD4uUEJIYjRUih6100zJPhWO5YrXF6djF1SqE24wEKt990
	6zw3iSdVbjxkpzYVXUaQ/1VnD49IG8
X-Received: by 2002:a05:600c:8b55:b0:485:3f17:425 with SMTP id 5b1f17b1804b1-485566fd0dfmr217500905e9.21.1773675859707;
        Mon, 16 Mar 2026 08:44:19 -0700 (PDT)
Received: from localhost ([213.195.231.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea98070sm999835e9.6.2026.03.16.08.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:44:19 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [PATCH iproute2-next 0/3] devlink: show devlink instance index in dev output
Date: Mon, 16 Mar 2026 16:44:15 +0100
Message-ID: <20260316154418.625026-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268193-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[networkplumber.org,gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,resnulli.us:mid]
X-Rspamd-Queue-Id: 6464829CADB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Support for identifying devlink instances by a unique index was recently
added on the kernel side:
https://lore.kernel.org/all/20260312100407.551173-1-jiri@resnulli.us/

This patchset adds the necessary userspace support.

First, as a dependency, introduce a fallback for mnl_attr_get_uint()
to handle the NLA_UINT variable-width attribute type used by the
kernel for the index, with backward compatibility for older libmnl
versions.

Then, display the devlink instance index in dev show output when
the kernel provides it.

Jiri Pirko (3):
  update kernel headers
  mnl: add fallback implementation for mnl_attr_get_uint()
  devlink: show devlink instance index in dev output

 configure                    | 22 ++++++++++++++++++++++
 devlink/devlink.c            |  6 +++++-
 include/mnl_utils.h          |  4 ++++
 include/uapi/linux/devlink.h |  4 ++++
 lib/mnl_utils.c              | 17 +++++++++++++++++
 5 files changed, 52 insertions(+), 1 deletion(-)

-- 
2.51.1


