Return-Path: <netdev+bounces-183250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64E8A8B773
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 13:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD841189C67C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C22723C8AE;
	Wed, 16 Apr 2025 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DuDwEREC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA59236435
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744801798; cv=none; b=U+Ni5gPm8no8zjUq5I2GG3dYjINK/7Sm+saJYlod4NNY7Z2uhO++SiCnQMA4gH3E76eAqyXmzxJ06R0VXgwYsLTkW20MSktPN0hBEzm6+1ToNVsdmibiCrtwumUwXDDD1bG9Vjo78PjNnpN6ZRy1ojbYHMXg8XMAh8y8oymd0pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744801798; c=relaxed/simple;
	bh=N300ZpabVRj6F4flL8Lfrs8xgF7O+jgFOpCvVDz4jH4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uYpJaLqYJwn2e6KLtXsGz6rqBXXr4NbV2Yq/OQooekq+X8YdXs5OWxcvbzGLx1PZfe9NcZZ9efE/XG/KiEUhG8iTjPEm/b4S34ezlsGWbqnEw1hafIvy4v6ofos0UUcFLVxHJV9mJJakOMszJkhhY/HD2Xbf7ZaHzE+SmdcnJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DuDwEREC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39ee5ac4321so408458f8f.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 04:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744801795; x=1745406595; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uUVn1E+5MASZtQAbRE/tz2lbT/kj3f2AwNu2uqycOxQ=;
        b=DuDwERECZX0nUED+9+NujIw+A2beToU3fyaa8eXcft6lO+jp+kPOgPq7F31HXa7l9a
         XPM93rbFlwG16nQAv/+ng4suDAKiSkD3/CfNow3+YYjUmY3JJVEN80pfjyk5lDCkBwkK
         G5Qu66G70QhKi4ttbcbHWFbyuYWtfHnezgWcSU5EjNpog0Y01QyLUhfkp3O8Ul8/m7PE
         FJy56mZiZIO8SQ7ZbRrfrV14fpvHVcqrGSm6bvdAJm0Iv04IXkQlaWAew0RhDd9cg+yU
         AaVx7M1b2IdhxLZBTfWYXtsOxB7PTy+uXaRxLqQqDZEL5cXj9e7t/mzNQmFVTskO5Z2V
         L2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744801795; x=1745406595;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUVn1E+5MASZtQAbRE/tz2lbT/kj3f2AwNu2uqycOxQ=;
        b=kBIkZMRz+3HXH3xgr454tZ3J9coyNKEEyfq1V85YUpTa4Ctuuycz3txF9JMhuWokNx
         gsi5cF8NrxchiaHdTV3GpHcbURYc++nJ3S/EUfa/O5FUTXZ2RH7V+WaNEoki+ePeXg6c
         x1lnaELsNbMjbCBSJteR0MmCuExQhRP/EcCcchxJ6KWLBP4nb5vriUC4l7rFjtah4oXV
         JtCE+9yXI3TxvsUSkRF+o3pEoob630C1VC2kyEQlnfKl2cp4+YARL26ygjAstaOTqcW/
         Rf6L7BrXzwsq+tVrbH85ajxphl7zjr3QLPCb46h4VnrqLrc8SCS8W/JR7lD4bHkQatsh
         rTnw==
X-Forwarded-Encrypted: i=1; AJvYcCXhY2AkVyAuW4ykg0ZI6CWetzzFiXdKrsb+zrWhyhTpT+oRgCJswcewNjRkR3N+rtGKHeuwhlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqFJZbVplc3y5U24Xi8rDqa2V3C9BTtFGmrYJRbeNt261n8y9D
	uvmQI19IhvsTBemem2U1pHAgG1tABjgLGICkokDoNFuYxxjp5XM9upnoULJ6p2C2T4JM5RKcmKY
	k
X-Gm-Gg: ASbGncsCF8MxO+1QR2my26r4k+oCh5Mn4CZrpwThbQ8Q8JpDVeO0JqQOzrPjLaimrVR
	epdjsxDHoJtQXYLtMyi5u6B8uwDH8HFxX88aCFQLglxgvrx/Z62Jw9z6ROeKr/3CnZxRZjDvAl/
	baMtBFJS63KGwEcsrtSobYUddFmuBOFMUjC+9+Va+OTqZ2cHT0Ur/v8x/9hDuYPm9AuZ5sU1uZB
	3VLhkXYoUF1tpY7MaLf8lEdjdPkHo7dMQGTN2dT/m4YtxEaE6BooHSheh/JWTE7+QN8GsYOPqXc
	TtHf9Jx99EvSmNlJRqbBM+ThgbR+xOLw3WLCdNeXleBaQw==
X-Google-Smtp-Source: AGHT+IGnbNlOdz2yVZBXGlqvERaHySPWwtoWVnzqqpbftBIEbIEdovohdZb+YF7/4pgI9k2rY2uGfA==
X-Received: by 2002:a05:6000:248a:b0:391:2bcc:11f2 with SMTP id ffacd0b85a97d-39ee5b10fb5mr1551778f8f.1.1744801794634;
        Wed, 16 Apr 2025 04:09:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39eaf445742sm17013298f8f.95.2025.04.16.04.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 04:09:54 -0700 (PDT)
Date: Wed, 16 Apr 2025 14:09:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] rxrpc: rxgk: Set error code in
 rxgk_yfs_decode_ticket()
Message-ID: <Z_-P_1iLDWksH1ik@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Propagate the error code if key_alloc() fails.  Don't return
success.

Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
It's not totally clear if these patch prefixes are real things or just
a cat walking across the keyboard.  "rxrxpc: gk: yfs-rxgk"  Really?
We expect people to believe these are real?
---
 net/rxrpc/rxgk_app.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rxrpc/rxgk_app.c b/net/rxrpc/rxgk_app.c
index 6206a84395b8..b94b77a1c317 100644
--- a/net/rxrpc/rxgk_app.c
+++ b/net/rxrpc/rxgk_app.c
@@ -141,6 +141,7 @@ int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
 			KEY_ALLOC_NOT_IN_QUOTA, NULL);
 	if (IS_ERR(key)) {
 		_leave(" = -ENOMEM [alloc %ld]", PTR_ERR(key));
+		ret = PTR_ERR(key);
 		goto error;
 	}
 
-- 
2.47.2


