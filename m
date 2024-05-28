Return-Path: <netdev+bounces-98617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAE98D1DE7
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A37A1F21D50
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E3F16F858;
	Tue, 28 May 2024 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2HbvMn8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9EC16F844
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905233; cv=none; b=VGphN7tGuCMwlS+R1L31Z2Yb7nRNy+XsrDCt1HmQXpoz9xvF6bUINGFSoUve87GmwtyZ8uPlK+ugsj8b1JVnpowjetNBCyEKoEbgAsAEbFoaLI4I2sc7PMViRUcrbzuq6w20g17Fas+7KGNUpeog4upecEzoOVz00gFGbAj2kNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905233; c=relaxed/simple;
	bh=7AWlqIz31VH+2auWG19awNf9Ol79+gqyQMhVO5xC260=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWbZvp25goGs2rNCGFVrtXyXhyH+xW6/sL51X7eG17hEAZWIWKjoI5Fwxa1odv8C04U3GHTIFI87p3fOPTJFbwJ1ysnUomti29bcHV8Z5lHlM/SnKm5HSwhxCZleFYGXO3qrhIqp35ViYf1zLy/rX2Hx0XEH1reYrMCdp5SK4SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2HbvMn8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-356c4e926a3so674652f8f.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 07:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716905230; x=1717510030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/eRqqpRId2hU8uhh2VGbfYucEQw3R2tB8HH0TtVdKk=;
        b=S2HbvMn8Z+HOmzw1V9TCdk5e8+Ql+RJtxCpqWrJX/46J2tG+KkIylY5kxk9ryjRtbZ
         DX1DO7LIDKLhb61FvNOTO+hLWOzFDUOPCSUFV0k8BSf2NfH3pLMLw9Ecd0nxhOfwqvai
         P2dQvztJ9XcpsMskRVAfy4mwGEuJVEPSCidma4iuT0KHdGrGvz8xnOEr8tK53jhZ889p
         uGupSpIE9jBf2lSOlzcFC3kY6OF8NhQe71t/YaONx6KDth8LyZGMfVWG7AQWf0YZBumY
         WH22cGr0vVxVboJ6M1oGWf5zR1C9/tex96kt4tRg2xRQkxhXicPdBpABllnRP5TJrHxY
         HWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716905230; x=1717510030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/eRqqpRId2hU8uhh2VGbfYucEQw3R2tB8HH0TtVdKk=;
        b=Gxssjw79UNxzuGW0FECGZMRR6sByLuEyYTThj3WytSs1lUHW/DK2RgTPPfx0YTBcXO
         7QF0V5fNKg7vpwzbGZAbfLQQrRwqOkhdvl/GgEidD4tcCCyO9ojG13AfQxV5FdlBAQbr
         H5OWIFe9MCtiNjKHsLLpqAsoAK+ALuDcxdCWqUKqJVRZXHV3I7UhIILzuZd3mGSJUOT/
         6poxU3kix9FaRyNnvMSd4j+/ajO/TGbyQGiNDztT4J0KVM2/CkCjsAn1sVuz/BC0sQP2
         ZWWzq/cg3Itl6bc+G0OHEdTol5QiPRVwaSkS9jKYBhWmudK8JEJpvgmXwaEM0AkX5TWn
         cKpA==
X-Gm-Message-State: AOJu0Yz555HyhzhXvTydL2s9Y1v+hApVReiJQ1xqyG1Pg7pHceFW6yhE
	VND70nqxOq51dboWJeYGQGNN1RKp98Sh0VCBYHJ3Rtav2Pz71mUY2EEthST7
X-Google-Smtp-Source: AGHT+IHidcE/qhSjftJB9oR4DkKrzsL4D5WztX9yJYsc7j0RFawFNV/ukEEkH6RMcqad3eBdXT3CUA==
X-Received: by 2002:a5d:4f8b:0:b0:34f:5d07:ebd1 with SMTP id ffacd0b85a97d-3552fdf2397mr8705503f8f.56.1716905230391;
        Tue, 28 May 2024 07:07:10 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:68e9:662a:6a81:de0a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-359efaf5402sm4534599f8f.78.2024.05.28.07.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:07:10 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Breno Leitao <leitao@debian.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 4/4] doc: netlink: Fix op pre and post fields in generated .rst
Date: Tue, 28 May 2024 15:06:52 +0100
Message-ID: <20240528140652.9445-5-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240528140652.9445-1-donald.hunter@gmail.com>
References: <20240528140652.9445-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generated .rst has pre and post headings without any values, e.g.
here:

https://docs.kernel.org/6.9/networking/netlink_spec/dpll.html#device-id-get

Emit keys and values in the generated .rst

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/ynl-gen-rst.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index a957725b20dc..6c56d0d726b4 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -156,7 +156,10 @@ def parse_do(do_dict: Dict[str, Any], level: int = 0) -> str:
     lines = []
     for key in do_dict.keys():
         lines.append(rst_paragraph(bold(key), level + 1))
-        lines.append(parse_do_attributes(do_dict[key], level + 1) + "\n")
+        if key in ['request', 'reply']:
+            lines.append(parse_do_attributes(do_dict[key], level + 1) + "\n")
+        else:
+            lines.append(headroom(level + 2) + do_dict[key] + "\n")
 
     return "\n".join(lines)
 
-- 
2.44.0


