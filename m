Return-Path: <netdev+bounces-188848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5C2AAF10A
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 04:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A03B1C04183
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 02:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D621B0402;
	Thu,  8 May 2025 02:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goosey.org header.i=@goosey.org header.b="P07wVs0u";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="VyXn+uXp"
X-Original-To: netdev@vger.kernel.org
Received: from e240-11.smtp-out.eu-north-1.amazonses.com (e240-11.smtp-out.eu-north-1.amazonses.com [23.251.240.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191DB1D5165;
	Thu,  8 May 2025 02:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.240.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746670445; cv=none; b=u+tY883HhKkevpm+6Il7/+OjG5koq/Kfbvvasri/CT1z7yMWcr611kyMKwQqtIwQLuteoC68BGrqhYPb/sFL9sO9FaN35pL9KuNFLkBY/4GUtAE/h6hpyw/+HmIwV0MwVjEQs9mgxXpQqtmYUJceD2pk8WgyVthDhno8268BZEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746670445; c=relaxed/simple;
	bh=poefmGJfofvP15Nt36Hm35/aBbmaEdFRT7/Zbyr7/yE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iT7kn2+pNwEQFf4Gg2tKnl7qcf5INytnVtcxDLRvB4lkZ5EXlY2Fqu+O9fNzWLW0BvZmHIlCvtSOvXApmwqR6lRvM83kMm/Z6lMlKIakenHuBw+sGADhbuQeEQFc0n+KJ9L93TQwi/eTW8toVWKEDqlHTO03zITptQI+qUigMk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goosey.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com; dkim=pass (2048-bit key) header.d=goosey.org header.i=@goosey.org header.b=P07wVs0u; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=VyXn+uXp; arc=none smtp.client-ip=23.251.240.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goosey.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=iuunfi4kzpbzwuqjzrd5q2mr652n55fx; d=goosey.org; t=1746670441;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
	bh=poefmGJfofvP15Nt36Hm35/aBbmaEdFRT7/Zbyr7/yE=;
	b=P07wVs0uKJuayteT8U7j5g1MuPLLaAB3JBY8e0NCuzBfSlLiObAaaqxiscMeIK6a
	kCS4XWypQicuWjacwOlpYhxQv4oHdY4YAagHyBI2s/1qIQ5d+gS66R4sL2rBHMv+OcP
	ypd+PAxBmEbwvRtCNkTJCKmGUThqD4G7rJGGvdpnl9g6ElwSHURLU82YaBevR4XOINY
	haRHoshPNZ/Ps/q4fQpEntvvEUCm06SfyUqAeyWmm9Bnl1R6ifI8GRJH6Pss9RC7Jl3
	XTS6mzUERkRXfaaTOhgoO0abkIQO0sR8HsX0tk7zMuz7lRbKHgBpZSVwVFY+PJsjRBR
	iXbiidEZrg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=bw45wyq3hkghdoq32obql4uyexcghmc7; d=amazonses.com; t=1746670441;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type:Feedback-ID;
	bh=poefmGJfofvP15Nt36Hm35/aBbmaEdFRT7/Zbyr7/yE=;
	b=VyXn+uXpescqmYp21gl4+QF45hTuoqGSuFqKno7WpdoX4jRruzEE82VcZFXRVOwI
	TiWORE5PaHmpyVXHhw9O5HFaHGsOs7Wmr1lRoUowsXnE44kcFlXR5tNVLzIBFE26mEW
	OTkY7qGZvcGs+fDhqJKHgp/CfjJ2EbekJYqlZd7c=
X-Forwarded-Encrypted: i=1; AJvYcCUmYVU0hwrvssQ80uhDDG3WRQ3u7/MtAc2TlS9dllG5V6N8lrB72SAvsrPuF5347Iwu9OHZbj6m@vger.kernel.org, AJvYcCXl7+vbuE+u5CvUJsWBJnoyE2+yf2N8VZMCN6y0NlDfgYZ5kBl5SgPW0VXElrtvbSlVmZ/nqk9liZfOBPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAXcsbd/PjxcCj8xPOSnNXSDx117J5v4s/k26qp0sEgvGnxowy
	9UQMhM+fapeLvcV0mNHS+xB2snHGISmPz0G7ybrgEV+jDZA1pZawqPT2D7QtyaAgt1aoaE+0NnY
	atg2eIZ+/Cj+7ouH969q+zdjqfXw=
X-Google-Smtp-Source: AGHT+IHFHTyfZ4T9ifPqXr73kDs7FxJtuk6pjrvncrBRp7/QMzmuo2IRKunODixNeWJ3aNsMClg+F8wIGMj8cKoeL/0=
X-Received: by 2002:a17:902:ec8e:b0:22e:5406:4f62 with SMTP id
 d9443c01a7336-22e847ce326mr24568875ad.24.1746670438201; Wed, 07 May 2025
 19:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ozgur Kara <ozgur@goosey.org>
Date: Thu, 8 May 2025 02:14:00 +0000
X-Gmail-Original-Message-ID: <CADvZ6EoGrp9SCvkVKEV0i=NW-7XZmxbmZkmxd8TPFboPTAUF_g@mail.gmail.com>
X-Gm-Features: ATxdqUEBQMdn1y1DGa-OqpAdEqho1UUS-FmqZpaLp_rDz0VPLAPMSxPSHAUfHd8
Message-ID: <01100196adabd0d2-24bf9783-b3d5-4566-9f98-9eda0c1f4833-000000@eu-north-1.amazonses.com>
Subject: [PATCH] net: ethernet: Fixe issue in nvmem_get_mac_address() where
 invalid mac addresses
To: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, 
	Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Feedback-ID: ::1.eu-north-1.jZlAFvO9+f8tc21Z4t7ANdAU3Nw/ALd5VHiFFAqIVOg=:AmazonSES
X-SES-Outgoing: 2025.05.08-23.251.240.11

From: Ozgur Karatas <ozgur@goosey.org>

it's necessary to log error returned from
fwnode_property_read_u8_array because there is no detailed information
when addr returns an invalid mac address.

kfree(mac) should actually be marked as kfree((void *)mac) because mac
pointer is of type const void * and type conversion is required so
data returned from nvmem_cell_read() is of same type.

This patch fixes the issue in nvmem_get_mac_address() where invalid
mac addresses could be read due to improper error handling.

Signed-off-by: Ozgur Karatas <ozgur@goosey.org>

---
 net/ethernet/eth.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 4e3651101b86..1c5649b956e9 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -549,12 +549,12 @@ int nvmem_get_mac_address(struct device *dev,
void *addrbuf)
                return PTR_ERR(mac);

        if (len != ETH_ALEN || !is_valid_ether_addr(mac)) {
-               kfree(mac);
+               kfree((void *)mac);
                return -EINVAL;
        }

        ether_addr_copy(addrbuf, mac);
-       kfree(mac);
+       kfree((void *)mac);

        return 0;
 }
@@ -565,11 +565,16 @@ static int fwnode_get_mac_addr(struct
fwnode_handle *fwnode,
        int ret;

        ret = fwnode_property_read_u8_array(fwnode, name, addr, ETH_ALEN);
-       if (ret)
+       if (ret) {
+               pr_err("Failed to read MAC address property %s\n", name);
                return ret;
+        }

-       if (!is_valid_ether_addr(addr))
+       if (!is_valid_ether_addr(addr)) {
+               pr_err("Invalid MAC address read for %s\n", name);
                return -EINVAL;
+        }
+
        return 0;
 }

--
2.39.5

