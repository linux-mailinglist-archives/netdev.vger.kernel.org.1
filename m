Return-Path: <netdev+bounces-37912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EF77B7BD0
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 11:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CC46D2814A1
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 09:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4886310A07;
	Wed,  4 Oct 2023 09:22:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB310963
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 09:22:10 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60548A7
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 02:22:09 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso18279145e9.2
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 02:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696411328; x=1697016128; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=60gbEhWeq8J+ivtYgPXcgmmUpJBTWg2RHo47BE0QpvU=;
        b=lAYkgPGC6vlDqbJKOJSW9oM9Cf82+B1WDRSP94LLVXWZL53wD6VaFs219fMk4jDqdt
         3iPgVQALkoGl/dZdD3KJa8Ke1zFQKqcuR7MXLgV0jayKtJysGqXf2E4ZnGFTyYDRUxKI
         oAAd3ISdbgGY4PVREncsTi+XjiBxW+awV8ZdXhNIsDnng/4hthH2hGYDQYfXiXBYU6sV
         pPJkxAArXRK5nk087B0XP8Kv517lXTe471ue7vfSAnc1mU0DzEXQH8iHQ6lw/ulC5mod
         pr3o4Dk5hG9lFXj4C/u+FQ1BlExLlxurTmamu2ruEugG2MY5/9xC8mhV5g2sSKO914hh
         h+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696411328; x=1697016128;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=60gbEhWeq8J+ivtYgPXcgmmUpJBTWg2RHo47BE0QpvU=;
        b=mzvQz0m5jcaIZ4pELBJZiudNYFG5XBg/E2LmBoZjQIDVOi1zXSjJH15P4a7Zw9sQxp
         POd/GWPUUrzeNiBssD+jdJg2IOja6NK7h8LupUWp1K7KmLxSS3YfWY05RIyLnrk5Oas7
         tahTDQJEJJ0nUv4Ri08W1or3Ds5KOdPWzefhlAz5ow85imkwShWvdxJt4uYL0MuEK8HU
         O+v1Ct44TB5sCCvFHMz67bz1HcvWhKDhtq4G6EM0mDXh34RYHvrMYLrM6paPTMYhH0/B
         0mc4Euz+Dq5EHnE412Oe7DUpxyhB9fPGXWC+LhQATupKTF5B0cFTrW1ESKOh/j8V5MOO
         av3Q==
X-Gm-Message-State: AOJu0Yx1n6Id6zFiwRBduobRkrSADKw4DvDeMqNzeUnhGPbCNuS+Zv0t
	w2vgx9zV0M3zlBR+pBLHa7yFjQ==
X-Google-Smtp-Source: AGHT+IFF519QprsBCJA7c7CUDqtHJ9oTO4EDKr8dD5MK+GaPkQNorbw/6dYKdiZ8MBt3fcugtqWK0Q==
X-Received: by 2002:adf:db50:0:b0:327:d08a:1fb3 with SMTP id f16-20020adfdb50000000b00327d08a1fb3mr1519689wrj.35.1696411327815;
        Wed, 04 Oct 2023 02:22:07 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a10-20020adfeeca000000b0032008f99216sm3508989wrp.96.2023.10.04.02.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 02:22:06 -0700 (PDT)
Date: Wed, 4 Oct 2023 12:22:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Angus Chen <angus.chen@jaguarmicro.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <joel.granados@gmail.com>, linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] 6lowpan: fix double free in lowpan_frag_rcv()
Message-ID: <3c91e145-5cd5-4d9d-9590-3b74b811436a@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The skb() is freed by the caller in lowpan_invoke_rx_handlers() so this
free is a double free.

Fixes: 7240cdec60b1 ("6lowpan: handling 6lowpan fragmentation via inet_frag api")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis, untested.

 net/ieee802154/6lowpan/reassembly.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 6dd960ec558c..1ccefc07049c 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -313,7 +313,6 @@ int lowpan_frag_rcv(struct sk_buff *skb, u8 frag_type)
 	}
 
 err:
-	kfree_skb(skb);
 	return -1;
 }
 
-- 
2.39.2


