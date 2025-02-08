Return-Path: <netdev+bounces-164266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6499EA2D29B
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 02:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B1516D1D2
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 01:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC9984D0E;
	Sat,  8 Feb 2025 01:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tNlsXaOG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D0276026
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 01:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738978124; cv=none; b=LglBr5MMzvwdcZTAmH9vnJoyYleGqXc9pBzwhfBXh80MzsuU9Xg9Jcw6UxZMsaI/swrVu/EHIgS+3Fn5UDaNEHaYbcI9jZQZrdTtdTS2oIDGs7G2IVf1NQ22yGQmQj+tMgZ99pYlsgadWn2cFrtR3q6quZEiqWFkMEXil+CelD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738978124; c=relaxed/simple;
	bh=F9r7BAv4PgGXAhDfk4jGDe5wzI28HN9K/csThIkDDVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dXV6sbf33fPn3sKw4mgNG/21GLIlbSQbIgIsGTX7yhINrHdhPWl78hSaPqhtIsDqUyubRlPHo72VkV/NjakiOKjNfO0p8zTKu3LaFfpfDqoXM1E+i7ijeCXMvNtWzd4jmL27UW7WRG3oHfNRQ3mj0yyTyp54KJ5tle624Ejm6OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tNlsXaOG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f6a47d617so3747965ad.2
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 17:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738978121; x=1739582921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C/jz6zfV+DBHmvoxAFtAoktT0KBDhc6UitGswSFEQiw=;
        b=tNlsXaOGnJGv54yuug2TQ3l7J8AARZmDHRB0RfvP+SdqZmgieZ2iE6WYUxuCJGi5v5
         J1BkYe346Aeu2zEaLWgz7spm9X3X1YIua5YOpiwsYb/mutPxuBGLvd+c+89PAwjZvV7a
         9nm4RTKRXO1vN1iyGSZfCI7vhqEcksMGj6sDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738978121; x=1739582921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/jz6zfV+DBHmvoxAFtAoktT0KBDhc6UitGswSFEQiw=;
        b=htRdxn4WKxryAH7JCsp7KuxwHn0Mpo0U5FImjOAaVOw6VWJTkvQzAtabmGbiIIysx/
         leWnavk37EJ7vxcheirCBezj4RWTBtXpdyClT+v83S5pSZhuVqNd/Fp0GraIUuuyiiqg
         FjEj1RTCN2fiamTGJXLEu00qogGRAJtmV5bBOyqEv5Znq6SNCJih9jDD4lR2sJr8BPtu
         GY/9VzmXzqXncLd+v8xd7YdhUVjblJGxyFXg24Zn6OKyrr7TKV8uOSF5ghKiQtuw3Eek
         Jup4S4Oe2P8rb/ns6xpP8rQDINKc6xg0hyr+lbMl5pVjRT6R+os6XrSSWEXdsDOTqGRG
         YyEQ==
X-Gm-Message-State: AOJu0YyE5xvVGX02+3RNpUQhUT610q3+2Ch4JZJWE7E48VUWCVKZHwQe
	uSyPeoUf7N3KxLX6rQ2KVRiYeIuHtEyBxylxZgeI5FwgNctjlaixqtoCt/3iMmT47V4oV/rdXG6
	hcK6tCfPUXCwaRF5/PlCuuEdZGw+AjepJBcUBOSyArUuVd4O2ZwR8qw7iau2/jlXSkJLNczTXdi
	tuIVZ1CYpOmpzL483M/ylTq9QHfJfxnSiM/9w=
X-Gm-Gg: ASbGnct4h/eB7EUlYtp5acClrDmuEzAliuQk2ob3gj0sxLHV19sURYclBedawTPxIVt
	N3pnK9qrUoYfQcwVerqigonbHqAwJrdwFXtFmXRKE8erft6XLF9nTSO7VAp58dRly/jjeNw9U2n
	uyVgokPuSSWahyT88A3p53z+ImZ30zGoGaBVTTG8j4rzoIxvr1ks8IFmdhqmRSuX3/3DWCOXi25
	CrJiEREoWui8jULr4JG3h1V4bA5CnIP2ClGU4SR7ED7wcl/cD93IcVTTeMM5TkK/FmwhQjcVyD/
	0CB3kJJ+cUgy7faT2XoFxV8=
X-Google-Smtp-Source: AGHT+IEHMwYdGBJpLZD807RWAj5yJcAOhKgdcOa+RZW7NQ/Y7a8uV/knvJSk/mA8Tb9bfo/1eDkKWg==
X-Received: by 2002:a17:903:2f8b:b0:216:1367:7e3d with SMTP id d9443c01a7336-21f4e70b204mr80906315ad.31.1738978121181;
        Fri, 07 Feb 2025 17:28:41 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51af7815csm3715311a12.70.2025.02.07.17.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 17:28:40 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: ahmed.zaki@intel.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] documentation: networking: Add NAPI config
Date: Sat,  8 Feb 2025 01:28:21 +0000
Message-ID: <20250208012822.34327-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the existence of persistent per-NAPI configuration space and
the API that drivers can opt into.

Update stale documentation which suggested that NAPI IDs cannot be
queried from userspace.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 Documentation/networking/napi.rst | 32 ++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
index f970a2be271a..de146f63f09b 100644
--- a/Documentation/networking/napi.rst
+++ b/Documentation/networking/napi.rst
@@ -171,12 +171,42 @@ a channel as an IRQ/NAPI which services queues of a given type. For example,
 a configuration of 1 ``rx``, 1 ``tx`` and 1 ``combined`` channel is expected
 to utilize 3 interrupts, 2 Rx and 2 Tx queues.
 
+Persistent NAPI config
+----------------------
+
+Drivers can opt-in to using a persistent NAPI configuration space by calling
+netif_napi_add_config. This API maps a NAPI instance to a configuration
+structure using a driver defined index value, like a queue number. If the
+driver were to destroy and recreate NAPI instances (if a user requested a queue
+count change, for example), the new NAPI instances will inherit the configuration
+settings of the NAPI configuration structure they are mapped to.
+
+Using this API allows for persistent NAPI IDs (among other settings), which can
+be beneficial to userspace programs using ``SO_INCOMING_NAPI_ID``. See the
+sections below for other NAPI configuration settings.
+
 User API
 ========
 
 User interactions with NAPI depend on NAPI instance ID. The instance IDs
 are only visible to the user thru the ``SO_INCOMING_NAPI_ID`` socket option.
-It's not currently possible to query IDs used by a given device.
+
+Users can query NAPI IDs for a device or device queue using netlink. This can
+be done programmatically in a user application or by using a script included in
+the kernel source tree: ``tools/net/ynl/pyynl/cli.py``.
+
+For example, using the script to dump all of the queues for a device (which
+will reveal each queue's NAPI ID):
+
+.. code-block:: bash
+
+   $ kernel-source/tools/net/ynl/pyynl/cli.py \
+             --spec Documentation/netlink/specs/netdev.yaml \
+             --dump queue-get \
+             --json='{"ifindex": 2}'
+
+See ``Documentation/netlink/specs/netdev.yaml`` for more details on
+available operations and attributes.
 
 Software IRQ coalescing
 -----------------------

base-commit: 7bca2b2d5fcc685b81eb32fe564689eca6a59a99
-- 
2.43.0


