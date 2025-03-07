Return-Path: <netdev+bounces-172823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44011A563C1
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03981896E1A
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 09:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63252054F1;
	Fri,  7 Mar 2025 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jj5z5QL6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120B81F94C
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339735; cv=none; b=WzHW+kgIKpF71CG4mKdr73b7nZtNFFjaw9TdVwKh7UjweyJezGZffyVCbnoZoMywpLWMVknub2+AJYZVXqxKEPBJS9p7+zuHjn+vWHGQxSiwDCCJKp9/U0p9rv8vFE/V4qj4YeFzQrbsiNOx1LuRaiTXwSTvG/6KEiNBxgb7pT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339735; c=relaxed/simple;
	bh=6YeoeqWkwCNXJnRk/T6zgTx0/hcyWZyOla3rDPddU7M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ELommFuoRw4v2aIMIgZOMHKU46qjW7AmUVUlYOe0Nw0v4TuIm6b3AEy7GszQo9tM1noCn4GcPr0N09fR3L1Gn9zBgaiZqfGgaUVpqOe2l1iiorvQoGyy48eIEKlmd2kK909cV3VSnK5/RXa8Bsiy0Ih1dsFKxmBYzvNsfmmCi3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jj5z5QL6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390f69f8083so1400966f8f.0
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 01:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741339732; x=1741944532; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Ju5ZbvhcNx9BRsCMH0Wbm+2RjeifjUfGKt0f6VkL5g=;
        b=Jj5z5QL6M2VRGpNNaTVDfm1XFMK0VFQyB29azUW9wibYIS75kkjC7xiPKi+kLHW/hB
         iEuUtILRLlr0NXptIw2uYX1p5zuPrRgjv2ApLSzpd1kUmdE6opw+gHQ2A4N2Y/yW8lNe
         wfboyZoRzrPGADWwb5fIurUPHz/eOJCQStW+riumANjjhJz+105AC64W/dYFdSIpyCxm
         UL4La3YFPcgHJOLVHb0ZV6Ba2uTJT4S3nvwoZoVHifPADB5XQ+dR01COnhrr0Xwvb1cd
         Rw/0xwzW2EjxGObnEJzw+8GqBSVWgpIJL15883x9N/IlGuoz5/9NReGvbiS6gXgIp2e0
         RTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741339732; x=1741944532;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ju5ZbvhcNx9BRsCMH0Wbm+2RjeifjUfGKt0f6VkL5g=;
        b=k0M//UAU6iYj+ykzapziFoLU/ueZnJtt2KZXlPs2xT74U7y0zFTL84gFFZh1eDEmsq
         mmMYyjVEAzln15ecj6ujI08Ty8MBBJM+j4soY0pz9BfkNbP8YM2VkjPO9JchmocIzmb3
         VIfqn0j07OKpLwIvgPv83vzpVQu4lWbrL0g/O+TAzNTiANKPWMFOzUFQLicJCrJe0V3/
         tj2e4LRQ+ZpgFxEZ/3YWCN0JDzhvr2r7FJ0L3/WXV7PKuzmDFV4EXAxl/BZGz3nNJDgi
         bMfGR9KgZ2sa0VLy9TGMCNaHZn26+6nBDUCtomXxGBZmj+63QUtnupkGety9D3wZRWyh
         w/7w==
X-Forwarded-Encrypted: i=1; AJvYcCXwNWxnpXj30r+MyqtWr/O1CIZM7pY8Twnjino+zdO7xo8hgtykFBWcufThkpG2LNCy4ZnM2wM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf3ky/s6e9vDouJ+Y46gcfOJaIB4Gx+6+/e/HoOo0Bm3RNADgl
	L9+cYAhQsbaLH6Pdq5iw4CoQPr7EDmUuua7+MVIOei+CsywZDdqj9eW15CESHPw=
X-Gm-Gg: ASbGncvzN4DOErzwjooYiQv4BSNF8HgERS8lw31PT6V/d45gHZN1T0qmJJqUI2aJbVe
	vzO/0TUv3B+4PMqZUc4vB/kPP/MmuFnm7mb8evhFBxaxjSCfuQ4gjpfemMOyi4g1UhR8EQBJAeM
	KunRPe+nrJGGEZNUIjEt3UYua/lw4x2KEeAJ6fk3gAjAS/b+zqiRlQpz+RNIKR2IGg0E+DX9KFT
	JjqwQER1lUt+9WOOWD4Yc9LIUzSF7iJcjq0jIyM+9ygbwArCa0rlUuhRXb/fA8wLUQPsoh7Jlwb
	BkkHbnbzU2Zwd4CrqYC6PilmCO/3iwryvmO9+TlC9AKsju1/dw==
X-Google-Smtp-Source: AGHT+IHy9+4P7rIHGn06Z9Wnp3OaLVatH22AMmyNL2OvUFsznE8mxvWG+6gIV29lYBEOGpcOgyg8oA==
X-Received: by 2002:a05:6000:1844:b0:391:3110:de46 with SMTP id ffacd0b85a97d-39132d98a83mr1919691f8f.38.1741339732054;
        Fri, 07 Mar 2025 01:28:52 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bdd8b0461sm47647725e9.4.2025.03.07.01.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 01:28:51 -0800 (PST)
Date: Fri, 7 Mar 2025 12:28:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lee Trager <lee@trager.us>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] eth: fbnic: fix memory corruption in
 fbnic_tlv_attr_get_string()
Message-ID: <2791d4be-ade4-4e50-9b12-33307d8410f6@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code is trying to ensure that the last byte of the buffer is a NUL
terminator.  However, the problem is that attr->value[] is an array of
__le32, not char, so it zeroes out 4 bytes way beyond the end of the
buffer.  Cast the buffer to char to address this.

Fixes: e5cf5107c9e4 ("eth: fbnic: Update fbnic_tlv_attr_get_string() to work like nla_strscpy()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
index d558d176e0df..517ed8b2f1cb 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
@@ -261,7 +261,7 @@ ssize_t fbnic_tlv_attr_get_string(struct fbnic_tlv_msg *attr, char *dst,
 		return -E2BIG;
 
 	srclen = le16_to_cpu(attr->hdr.len) - sizeof(*attr);
-	if (srclen > 0 && attr->value[srclen - 1] == '\0')
+	if (srclen > 0 && ((char *)attr->value)[srclen - 1] == '\0')
 		srclen--;
 
 	if (srclen >= dstsize) {
-- 
2.47.2


