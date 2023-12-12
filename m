Return-Path: <netdev+bounces-56612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D842980F9F8
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F32282123
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABDE64CD8;
	Tue, 12 Dec 2023 22:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K9hX+p2U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6678FBD
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 14:10:00 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5c69ecda229so3524861a12.2
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 14:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702419000; x=1703023800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6AUQroc3YD1KExvZg7CZoKlnozDJQ13H2P0qin79AMs=;
        b=K9hX+p2UoWn+0LgirSssfSrjwvLWHcyyrZQL992KJ8Epw8COFLUDzK+z5eOp4nGcpL
         G5nGIi564ReabHJpSJNRTLCXkFedyxOnTPdXahUE73R+RkmU7pcykPSKznjdZW4ybSdR
         QEjfQB8KsPar2JZy/k58VmpUqeZ3SbS9oT2pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419000; x=1703023800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AUQroc3YD1KExvZg7CZoKlnozDJQ13H2P0qin79AMs=;
        b=s0aEsJAQX9Uqq+Es3ifkzCKf7moOaJoB/0ceGpD7f8Kw0USav66A1YBoXpvLt/kT8I
         0MM7ItMj+1miQwsZEnZcTtQiBxPrbUXLf8srS3Zb453e5sRkKXbQg1kTvtEDYFxnDvgv
         qZDjnHRcUVvF42QnKbLhwzheWgHZcebK2KzKNV6x6xrEByLa9bEaOJ5/97BhLUa6MAU+
         1bPzB1KMtQ+npyg/p/YNaEmPb8j+d85fn15LQFbg+NJmv+31xostbBqcy034EgO4w/O7
         RxNOYcfVWL19nNsjql5ptkPv2LE2YfwVMhTSPXXg1nRRvw6ncutm89PZ52S9iDZIdqlP
         ll3A==
X-Gm-Message-State: AOJu0YyciSv0IqyCpwD8soqs0fL5YuCJrAiOBGiL7RdElBG7dU0QM3W0
	8HifhS1i96SsNC/ecOGJ4RW8vQ==
X-Google-Smtp-Source: AGHT+IFf+R1A/XR8Jt/9Fz875DIYyIaNu91bfQZimMKleNPgzgfwmHSBFbbtlfKJAsRdJ8rj8kU4YA==
X-Received: by 2002:a05:6a21:1f20:b0:190:2973:5132 with SMTP id ry32-20020a056a211f2000b0019029735132mr3660108pzb.107.1702418999822;
        Tue, 12 Dec 2023 14:09:59 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l15-20020a170902f68f00b001c9c5a1b477sm9139392plg.169.2023.12.12.14.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:09:59 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Raju Rangoju <rajur@chelsio.com>
Cc: Kees Cook <keescook@chromium.org>,
	kernel test robot <lkp@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] cxgb3: Avoid potential string truncation in desc
Date: Tue, 12 Dec 2023 14:09:57 -0800
Message-Id: <20231212220954.work.219-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3659; i=keescook@chromium.org;
 h=from:subject:message-id; bh=21c8W8WpyGXddpdivNfij9Z1UgBS9gpwm3BMCk5vJXE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBleNo1YdSK7BzSkz1ECFrVzjTTKZu017tFXk7P2
 MuIZKMu6B+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZXjaNQAKCRCJcvTf3G3A
 JrU6EACVuFlSTH8lVGBKuS1i7DgrLCjEdSotDiCDkaaC5uHjvNymaLN3etMW/BIzpqALRP1VXQe
 +BvMKtmUKXuNjHll4E7H6ZWn6Kma7bX+MaEiZFqCLrr3SKj2GpKBCe3k+9ajHJLxL6MrghA1nlT
 nudc/lmnJeT+ujiOIGLgzMqasPIwcD82I4kuMcDssolDzdPoh0LBAb2ZuxlLiX8CluyR/f1cz5u
 T4NCzvqNNEUDMCiqADL31XkQbMs2NsLVa8xpcBkBYTWwyvjOss3bbagakrYrMGGCEJQBiAHttJz
 1NGygZ9pCL/CSfVnJiTosCA5woY14NI19hTegJlcHd9NT+fnuSBMO3JLs0FDBSjnPnFv9jxB9t5
 ROWEUKlb9PQaQTI2EOOzen8AvyrzZA3t8DDef1Tf2lLMbJ8zSlPswymr2TIFLUAcH5gJg6t8Sil
 Hl8zGlTTzkQoz5CBZ3EdjA0xhuOO1EKLuLKUwAbQ5NPI4W8KV1WMNGk8I5p8kELLmjlDmTsMtmw
 xyUVwFHINyu5yD5VSUxTGAnJDcVM56uX1IuLYRtBHfriKRBwKv7CZ9BAYKTYqATeZKRIAKfe+Y9
 KXP4u+c1c668QPpD99DQMb2n0Zf3z2iF76/vR2JA8ac3BljgNHdUD61MOfF7oHj8qBpFoV6G+Xu
 6LouMnn auXbTADA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Builds with W=1 were warning about potential string truncations:

drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c: In function 'cxgb_up':
drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:394:38: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size between 5 and 20 [-Wformat-truncation=]
  394 |                                  "%s-%d", d->name, pi->first_qset + i);
      |                                      ^~
In function 'name_msix_vecs',
    inlined from 'cxgb_up' at drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:1264:3: drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:394:34: note: directive argument in the range [-2147483641, 509]
  394 |                                  "%s-%d", d->name, pi->first_qset + i);
      |                                  ^~~~~~~
drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:393:25: note: 'snprintf' output between 3 and 28 bytes into a destination of size 21
  393 |                         snprintf(adap->msix_info[msi_idx].desc, n,
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  394 |                                  "%s-%d", d->name, pi->first_qset + i);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Avoid open-coded %NUL-termination (this code was assuming snprintf
wasn't %NUL terminating when it does -- likely thinking of strncpy),
and grow the size of the string to handle a maximal value.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312100937.ZPZCARhB-lkp@intel.com/
Cc: Raju Rangoju <rajur@chelsio.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/chelsio/cxgb3/adapter.h    | 2 +-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/adapter.h b/drivers/net/ethernet/chelsio/cxgb3/adapter.h
index 6d682b7c7aac..9d11e55981a0 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/adapter.h
+++ b/drivers/net/ethernet/chelsio/cxgb3/adapter.h
@@ -237,7 +237,7 @@ struct adapter {
 	int msix_nvectors;
 	struct {
 		unsigned short vec;
-		char desc[22];
+		char desc[IFNAMSIZ + 1 + 12];	/* Needs space for "%s-%d" */
 	} msix_info[SGE_QSETS + 1];
 
 	/* T3 modules */
diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index d117022d15d7..2236f1d35f2b 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -380,19 +380,18 @@ static irqreturn_t t3_async_intr_handler(int irq, void *cookie)
  */
 static void name_msix_vecs(struct adapter *adap)
 {
-	int i, j, msi_idx = 1, n = sizeof(adap->msix_info[0].desc) - 1;
+	int i, j, msi_idx = 1;
 
-	snprintf(adap->msix_info[0].desc, n, "%s", adap->name);
-	adap->msix_info[0].desc[n] = 0;
+	strscpy(adap->msix_info[0].desc, adap->name, sizeof(adap->msix_info[0].desc));
 
 	for_each_port(adap, j) {
 		struct net_device *d = adap->port[j];
 		const struct port_info *pi = netdev_priv(d);
 
 		for (i = 0; i < pi->nqsets; i++, msi_idx++) {
-			snprintf(adap->msix_info[msi_idx].desc, n,
+			snprintf(adap->msix_info[msi_idx].desc,
+				 sizeof(adap->msix_info[0].desc),
 				 "%s-%d", d->name, pi->first_qset + i);
-			adap->msix_info[msi_idx].desc[n] = 0;
 		}
 	}
 }
-- 
2.34.1


