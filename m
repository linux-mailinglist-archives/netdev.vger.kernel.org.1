Return-Path: <netdev+bounces-209270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E52E8B0EDBE
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE80E1884E02
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9C6277C90;
	Wed, 23 Jul 2025 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="GzqYYL3N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9C527D782
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260926; cv=none; b=E+J0Ze22GbDbNR3/m2knp/y94CwcLrgL9O4pDSa/riJahBUQPva0pQoJQXU+fEpRBHWjZwQJiiNIEvJbVgsMg7GvF6jzt4A0mwTohVH7k5doEkXylQXwPy1Aa+mzuJFJ1FReCNvIGlCzlNvCNc25NZfdyJl1aWdaa8nxy+ASp14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260926; c=relaxed/simple;
	bh=gVHokdSRl+H41Z92twi7NEzrrYzPZl9Uy99hy2FpKgo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tnEuNt3jKskpR2VkUcpsUNnxP9bGBY+bxtHSZmr7dH9n6YD7WAkfR71yBGfvzANF25ThirPphr8QaXhlnhq/XF4wbXpkLCOqWVzP+GkHqZxFpaFwSG+dMcwkVbD6HfF3AkElnRLw/b0TRvIwAsiGKcSYdysjsJn9Vl/TvjOFoWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=GzqYYL3N; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae3ec622d2fso1074986266b.1
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 01:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1753260922; x=1753865722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=juzgHf2ePJEjJPl/5wnbYlH7avu5i3YmzhJWj+DcCT8=;
        b=GzqYYL3Nt9aFkhvu1Er+ocRSAJTizWDLnhrnEZxzwnTqXDBPyFKwlf4YANxogpnCz+
         j6StWTQcIf/6NIdxtY8KUvQUOG9TbBE2D/8XYjpAQM8Vaa1bAK6JySpC8xxm9xUrJnFV
         f0rY8Qa7AGA24OevtSwFBgSP5d6bOAJmf5aLqbEX9I1G2xlwQeUIEKScl854NMcD1NC0
         mxUPMyYLoKUA84KgBszOGAgc51NAS98p0Veynarazl2TtvwFYAt3wtxznjAGNZYbSTCF
         6nDAWKqB01cwn7LOWhoxpE8X6d0W/ydfFMzpkgMuRQXg5KFdLeA2ee23jUU40K0Avj9E
         vQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753260922; x=1753865722;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=juzgHf2ePJEjJPl/5wnbYlH7avu5i3YmzhJWj+DcCT8=;
        b=sG/3UrodsdAae4Hxf5bFoTlrdRLPDORn9l8n/oOho34mzq1vdb8/on8fydoCoOZq6p
         52BWSzCQ2zWAO6/PBVKclS2BuFPYocVMyg+ImQ4E6HSFDMXiXzh6nn7RFuxv706yHoC6
         GR18zQSUPnAm7M8ldN/EDRC4Al5ELYq4yV6PQ61TkLhR6y2vy7/zHYhccUblFfO5mTcO
         5O6//QZt/xsEirzDMiuFTKamrFhQz/cbTw9in4LflxJi9RubtlZ0q+hszzzOzFnngs4E
         QcmNW7yVXsq6RINryj1Ynvu9yNDFpbzGy5lLuj2GfD6SNsbEb0iKqzbBJP8kPW2eElZl
         8hMA==
X-Forwarded-Encrypted: i=1; AJvYcCVyZNsE30O+ZETeg7Dq/9xqKdgzPUjk7HeUDq+rqkierhbt3O6HNMiON9la4n6yIwMa1YIbC38=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMkJV+m25VPsk2vGO0kp0uqQrh6P1JTTZnPc3GbMsYlo88QteZ
	3tIpoKGnqb/QXFGSv48ySTYvvEcCfhdB3/KJDr4P+wPrF2Nm/vUZiIg4dVjTCAMlUg==
X-Gm-Gg: ASbGncuP7clG/zd/UQly6gmduIjdFQ53XTg/Qlz08PYYR77cRAC2C1/zubGy0TLj5xP
	BnJ2r/yZfRFiXi5QqXTbxEb41KeEgR4NiKEiIykWu2fAknS35ObcSDAt52Ls8+gltmE/DnAbP7L
	hNhHuudf/LrbL/FbTkHwpaa/SXuX3nW4amTrX0QDgjl7PnjS4eEaCidysANP9MrF3CWren9qdjD
	OwpYWbUk3rXjZoJ2mkKGQTjv9ljuwTZ4vWCEwHJa8QCRKV5GX6RGzO2qxBjq5SslPcijlZ9BLkM
	YdayWqiOfiTIpG69ROgxgwjNX5dhr6HtY6jnbkmZlzmAazZrlUl/U0EQFpkMTj8pVfBozJ7q7de
	Xq1uSzNXjWSw++rOhmI5+DTX+
X-Google-Smtp-Source: AGHT+IHmPfACLVJN2IkyJNVnQR5H3t14T3MZHdHktP85g0699zkzu+AM0vhSyq1zboQ8p1wx7g3EQg==
X-Received: by 2002:a17:907:7f09:b0:af0:f3d1:ad04 with SMTP id a640c23a62f3a-af2f9872c59mr179109466b.59.1753260922400;
        Wed, 23 Jul 2025 01:55:22 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f37089sm8193809a12.20.2025.07.23.01.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 01:55:22 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <8ae30b40-04e5-4400-92fb-86101b5c667d@jacekk.info>
Date: Wed, 23 Jul 2025 10:55:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH iwl-next v3 4/5] igc: drop unnecessary constant casts to u16
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <2f87d6e9-9eb6-4532-8a1d-c88e91aac563@jacekk.info>
Content-Language: en-US
In-Reply-To: <2f87d6e9-9eb6-4532-8a1d-c88e91aac563@jacekk.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove unnecessary casts of constant values to u16.
C's integer promotion rules make them ints no matter what.

Signed-off-by: Jacek Kowalski <jacek@jacekk.info>
Suggested-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_i225.c | 2 +-
 drivers/net/ethernet/intel/igc/igc_nvm.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_i225.c b/drivers/net/ethernet/intel/igc/igc_i225.c
index 0dd61719f1ed..5226d10cc95b 100644
--- a/drivers/net/ethernet/intel/igc/igc_i225.c
+++ b/drivers/net/ethernet/intel/igc/igc_i225.c
@@ -435,7 +435,7 @@ static s32 igc_update_nvm_checksum_i225(struct igc_hw *hw)
 		}
 		checksum += nvm_data;
 	}
-	checksum = (u16)NVM_SUM - checksum;
+	checksum = NVM_SUM - checksum;
 	ret_val = igc_write_nvm_srwr(hw, NVM_CHECKSUM_REG, 1,
 				     &checksum);
 	if (ret_val) {
diff --git a/drivers/net/ethernet/intel/igc/igc_nvm.c b/drivers/net/ethernet/intel/igc/igc_nvm.c
index efd121c03967..a47b8d39238c 100644
--- a/drivers/net/ethernet/intel/igc/igc_nvm.c
+++ b/drivers/net/ethernet/intel/igc/igc_nvm.c
@@ -123,7 +123,7 @@ s32 igc_validate_nvm_checksum(struct igc_hw *hw)
 		checksum += nvm_data;
 	}
 
-	if (checksum != (u16)NVM_SUM) {
+	if (checksum != NVM_SUM) {
 		hw_dbg("NVM Checksum Invalid\n");
 		ret_val = -IGC_ERR_NVM;
 		goto out;
@@ -155,7 +155,7 @@ s32 igc_update_nvm_checksum(struct igc_hw *hw)
 		}
 		checksum += nvm_data;
 	}
-	checksum = (u16)NVM_SUM - checksum;
+	checksum = NVM_SUM - checksum;
 	ret_val = hw->nvm.ops.write(hw, NVM_CHECKSUM_REG, 1, &checksum);
 	if (ret_val)
 		hw_dbg("NVM Write Error while updating checksum.\n");
-- 
2.47.2


