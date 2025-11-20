Return-Path: <netdev+bounces-240266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB50C71FE7
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 04:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id F2B7D2AFAB
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 03:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25F13009CB;
	Thu, 20 Nov 2025 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="s87R4Ft+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455E92FF65B
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609428; cv=none; b=IrkGggpybvTww/NGrmXfft6EOqP7ABhCm9KMH407vNTGV1ay3Wd7Q3f3elcNaWjYl02j7nUGEJtxRaZMl9mUskmLh7zcetnrTKrXW2vT9XPuCJtwbZ34Pw7LHb6UUObVyxHw1pYxPFt/5ZD6Dj95X0Z2JEQ0iNGLlm5XcFPQKpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609428; c=relaxed/simple;
	bh=3dzdDFVdiEPNKym0yCmxUNh+RQXrvtRHEez2LG8Zr5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nooB1XS9yyG3NTKh8FXf2bCuf2lfYwXhSCU2Z/aWGdcDLEfHmRrP7xDjESoEFsV4ZoofrJL9vM/aSNEiunBKY+cspCt8F7MTpaNbkU6PsFWtTTj9Kufrnjd218ypmCLvaaTB622DM0nJjgp1aRIa0gkdCXHBDyYYY1iY2N4p4EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=s87R4Ft+; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-450252e3bceso95200b6e.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763609426; x=1764214226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYqZQ2VZMehhev6ct3exQUNNpN1H7iK+QE3fcckx+c0=;
        b=s87R4Ft+PY1k3qVuKRPcS60lELQyJwXti4HwAp+DepNdxEur6529iNfAvJ4YFQddMF
         Ap+TP6ZvQrBa03x9JUrHdthMHoAqxE9w/lVdaTQkYt7JL7JUN24zn49mzSz66Ecnn12G
         Rr3s0Igxh24zIGWBR1ZS+O9prn1GDFjx7uDxbQ/EzUe16G9pjXwb2EsFFW46n+v83soB
         6oEP+PQIqhk9sROh8bD23+rMDWZFL46FkkOBbu956YYtabWXNBkaLt3XwmI2p52GAzhl
         y18vkKL86PZz0rnOBJAFmSQ4Hjx11H2bhsLJPTwaz8+2EdDizJ0iHn+YC8RX6RT3BMmV
         QwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763609426; x=1764214226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sYqZQ2VZMehhev6ct3exQUNNpN1H7iK+QE3fcckx+c0=;
        b=MPoQjtKEDlTaUC4nnnAy81qH93D34VkHwLlOeNRHh3xhFUysUf1/NaMb0d0faOoVyR
         tkqXz1ErPP7TRC5eyfS58CVodpKPiyr4cfhWQ26bULzVO5ArHa3FF2htZEkKm5k9FWOI
         BvXDGbyy9VgHpfA3eJGY8ubwBWlsQLZhC+nrfJU7ubsYTeu+wX6bkJaczTZ60gpyUjDT
         1zYLzLTiM2v28ozLiAe2+CTxieod6G3t9uUUtOrv1bYN0KXL3cFZe3MqX5Ld8xdnkbw/
         e8w9utzynrizWYOsC6cjp8bBc1E86QeEABsMNXXaZga/rq9aYqBBPotuT+iGmRHiscHh
         g+7A==
X-Gm-Message-State: AOJu0Ywb6X0aiWwmgrlQXOf5a0omJQR06hA+QOUB88Ns8EWX/OrneRzR
	YQCf47lgjsDbJV6QSrCxXlB0Qj1gND2NCXvBzhY2GrhO/OGWYP2mYnhZ7YcEqq7ER15JbQ4T2Bk
	LrrNq
X-Gm-Gg: ASbGncs3EaCjr4R8VyxDeH4UEiKyvygB2efxhtXiR8xA0AvHoCzYn7k3Uk0bPoxI/oO
	gbs39uUkoGM0Y6JvoAaXL3d/vuTnCUzW/t35wz2npWSN3Pn5krPD+KmNHVs5z8k5Ha3s6Dcs/PB
	lHIwGHJrA0sOq39aMqieDgXbJpb5Q5J2qx9vQD3HO7St2f2872uaC+xnpwVe4as8ZqeXBQIg+k5
	JTOz6Ya0gzwoUuGgHg8+an/NzZyhkLcLA2p1KFgLflEp6lwfVmDFwe35ma3xkt0+J9pqz2MVD4X
	9xQfzGe98Y6/sHmdRi439vzX7Y6drx1DMCU0vPl4unpnheOTCI+1W2Sbpf0G/dv9LOek5jcYkLa
	BvJhklbGiTgLzRL6ZmUcW95fuHc13kpi7MxA8yM2UuAMHfc5+i2Rg/vT98jtpvSMH51UgdNOqcK
	CqhihVJtMCaAf9FPecWREoMIeAGow8KXKi5r1s214a
X-Google-Smtp-Source: AGHT+IFdfpRNDFBzBEcvwWcoGNeeh4V4hwW/XAMT1eRe0tCitk0Ruma3CBkuKXmQRN1esm2tlSikig==
X-Received: by 2002:a05:6808:c14a:b0:450:6eb0:349c with SMTP id 5614622812f47-451002479a7mr714746b6e.40.1763609426330;
        Wed, 19 Nov 2025 19:30:26 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:4::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65782badb38sm451515eaf.16.2025.11.19.19.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 19:30:25 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next v1 6/7] selftests/net: add LOCAL_PREFIX_V{4,6} env to HW selftests
Date: Wed, 19 Nov 2025 19:30:15 -0800
Message-ID: <20251120033016.3809474-7-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251120033016.3809474-1-dw@davidwei.uk>
References: <20251120033016.3809474-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expect netkit container datapath selftests to have a publicly routable
IP prefix to assign to netkit in a container, such that packets will
land on eth0. The bpf skb forward program will then forward such packets
from the host netns to the container netns.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/drivers/net/README.rst    | 6 ++++++
 tools/testing/selftests/drivers/net/lib/py/env.py | 1 +
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index eb838ae94844..ea2d3538e228 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -62,6 +62,12 @@ LOCAL_V4, LOCAL_V6, REMOTE_V4, REMOTE_V6
 
 Local and remote endpoint IP addresses.
 
+LOCAL_PREFIX_V6, LOCAL_PREFIX_V6
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Local IP prefix that is publicly routable. Devices assigned with an address
+using this prefix can directly receive packets from a remote.
+
 REMOTE_TYPE
 ~~~~~~~~~~~
 
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 3e19b57ef5e0..ee427c2b2647 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -196,6 +196,7 @@ class NetDrvEpEnv(NetDrvEnvBase):
     def _check_env(self):
         vars_needed = [
             ["LOCAL_V4", "LOCAL_V6"],
+            ["LOCAL_PREFIX_V4", "LOCAL_PREFIX_V6"],
             ["REMOTE_V4", "REMOTE_V6"],
             ["REMOTE_TYPE"],
             ["REMOTE_ARGS"]
-- 
2.47.3


