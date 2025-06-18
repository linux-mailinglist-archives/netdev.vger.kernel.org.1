Return-Path: <netdev+bounces-198968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503FFADE717
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C049A17FD46
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F68286D6F;
	Wed, 18 Jun 2025 09:32:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12823285CA7;
	Wed, 18 Jun 2025 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750239177; cv=none; b=qtwPNTHyzvsKmy92YGafXATb7Bbbl3tbqyOuDwtDKyeXFSVhEtUiaP58Ai7p6v/ogfHghCDBE6zK6OYFjpqATj3tXDoEAPkrTAzVJn7IPAgANum2DWp/2SZZ6uSr+TybBzChjx7UnINHXPjPwmALd7JFChGe1EstMgVvgmMysGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750239177; c=relaxed/simple;
	bh=xsT5+BNApZ6jnctTLrkNgwcX9E+gvGWHHUk/Qw1k1RU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tOIle8WaT6y6YsGJBO1LORR0OJs4l+Bnl2VOIz94d8FeOv5h6ysnBJnjigMH0vwNc62stxEic+NdEuSLooqyrvPs3GNQAqvmWXO4i5LMX76lwJpULH3TbIWUNQiHwybRq9+TXuIq9vt+sd5DR0qF2bZYlfbbmQlKF5gFe3CVSBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so1228406a12.1;
        Wed, 18 Jun 2025 02:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750239173; x=1750843973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6p6CJREvtO1XNGAKGo8PsXvP3/MHGJcajliyymJsnY=;
        b=MTRRyK1MlLkD9DSPKSQCuIyURd8e+XGBENZvy1b7aOFTjwSetZ3Zx2TnNi/ktQTlCK
         KrBTJhhaXdYgWGtV2btfEc6t3JQIL28XplxK+8uClpQowCAUSwMz1kguI/9YejDDxUdP
         FDjIRmxV1s7+VJSLPj8B23jDKJRdJMfnKAkirUpfCtQzLz9lTDEh7IzfjLb10U87bGGR
         bzSBlQDpCE9wGIdw6p7W+ityITVPWL66qFxRe1Do47JEsMdBGWMeCayb73qAOBo9d/5q
         +AJ2BsGEnGarKUE7prCTSjleir3YZ9tqN+bcN0lajI4ZZ+OmMQwTtuEsVUd2dLf0Ogjj
         b8vA==
X-Forwarded-Encrypted: i=1; AJvYcCVfILZQIgQmRTessC1JcsK8IP8BjR23Hxlwz66cjMJATzXBWMiTkHT9kunHKYmmKJRExOO2eaUG5qRSkd4=@vger.kernel.org, AJvYcCX1l5J+WpdXmhP0OSEHrau0ei9AeMR2tFZjR8foYSnzmDs56B11B/sNp+6H844wrg4cLfLVcY2N@vger.kernel.org
X-Gm-Message-State: AOJu0YwK5npGxoskYuHkOA67Vz8r6YP84ttB80By8tJBfyO1RfOhNEWb
	cxUu3n/8xHJX0UQ/3s2/T59L3WUsbpcT756ZvQTvaolgsQMHfdadn++u
X-Gm-Gg: ASbGnctsdu7UeUfbEtQ+yhiklbnCkm/QXPsa4nadWgtE9F/9dRIeQunko6HahsepfM/
	Riwiv25hqI5s3d1XjS5i0r7XDfKl61i2aV2qIg4mqdDhViCdZ5vL6v5XqGn/MNRqcdJiHrBkfAl
	mXo3PljB2xmfW2rHEQ67sEmFPorC/Ot/f74lwLVVk6gMypiF7Vp6zomdPIqaf+tz2LWy0I0vUtx
	EP4hhC5u4gAkIS6FhthA43PmmebUGvXZkQfLKrWeX4YpPf58QP2E52DfMEKCe7CeZcFQSrvq8ru
	D1umeqTMXYuwbeiVah4dT6/ybmodGLgYIgv5FkouptudIQeRmv8o
X-Google-Smtp-Source: AGHT+IGgFOXfHVZAMfP0pQLGkzzAuYN0D3m3K6HvSVU+5WMjrp8oQ75diCPCWqY8eQveNZ5fnrtFJA==
X-Received: by 2002:a05:6402:50d0:b0:607:f42f:d58e with SMTP id 4fb4d7f45d1cf-609c1b3613cmr1421871a12.12.1750239173166;
        Wed, 18 Jun 2025 02:32:53 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608cfadeb92sm7951571a12.13.2025.06.18.02.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 02:32:52 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 18 Jun 2025 02:32:47 -0700
Subject: [PATCH 3/3] netpoll: Extract IPv6 address retrieval function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-netpoll_ip_ref-v1-3-c2ac00fe558f@debian.org>
References: <20250618-netpoll_ip_ref-v1-0-c2ac00fe558f@debian.org>
In-Reply-To: <20250618-netpoll_ip_ref-v1-0-c2ac00fe558f@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: jv@jvosburgh.ne, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, gustavold@gmail.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=3278; i=leitao@debian.org;
 h=from:subject:message-id; bh=xsT5+BNApZ6jnctTLrkNgwcX9E+gvGWHHUk/Qw1k1RU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoUoe/oxEWlCEvp9syhQzSeHRmj67NB36R9BhC/
 yptggTPNimJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFKHvwAKCRA1o5Of/Hh3
 bQvKD/48+af5LplbvaZV0RbJCddg63q0nCsr+tAgUJW/rwuv92kotqZ+vOUDZ6fOpocJK3s22UM
 Cf/wMVd//LPfEm1KU6aPjg/IBI8Kbkr3Er+aPZmOzVM2r280X8OUWSwLTya3uTyVnfSC8ZZ5yWZ
 d0QwDxECUxfPN6v7taE3TkJr6oQKeHSvhQlgjzDT9faSMb5JiRux4IO2bJ840I9hJo1vJGxGFUp
 bqecYT71ARu8FF2vTNDfSglygywACCNWuw8W1efExy6uWrpMlmnmNX2rTJsBFi2LJacJL4qMF/D
 MMr52xyEviiRJ45XiknM3gdCfUiyNPX84MMRpXSUtq8eI8H6/K7t0pqV4YAzohYQg3bOUHUyvL1
 KKcmog/w3kPxSLX7trIjtDGlPmn4RScmIwsrWx2NT78xmM1Bc1rzj3FSx25h+B8cqt2TRbimyUx
 MRvBanVbdPnlXwihzVSzcGIoCMu+0DOXtdAGzup+5yja4ju72xtSAbbpiaFLwrb2vdm6Bwom09Y
 hccUtb8pug1Q07knZ2r3ICEhg8qaix6Bdvo7Mw5aRocPaS9IMUyC3UoHnnnieWfEdb9eZw94/oH
 9WquLJ9wrO8wEwodU/hAS3pxucz4V+l37Hj8tdOJIh0PLfxJk41yYMr73DeuX/f9msGH6rq1QLH
 bfTQjfg5tCdniQA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Extract the IPv6 address retrieval logic from netpoll_setup() into
a dedicated helper function netpoll_take_ipv6() to improve code
organization and readability.

The function handles obtaining the local IPv6 address from the
network device, including proper address type matching between
local and remote addresses (link-local vs global), and includes
appropriate error handling when IPv6 is not supported or no
suitable address is available.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 76 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 6ab494559b5c6..7021ea45a0539 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -598,6 +598,47 @@ static void netpoll_wait_carrier(struct netpoll *np, struct net_device *ndev,
 	}
 }
 
+/*
+ * Take the IPv6 from ndev and populate local_ip structure in netpoll
+ */
+static int netpoll_take_ipv6(struct netpoll *np, struct net_device *ndev)
+{
+	char buf[MAC_ADDR_STR_LEN + 1];
+	int err = -EDESTADDRREQ;
+	struct inet6_dev *idev;
+
+	if (!IS_ENABLED(CONFIG_IPV6)) {
+		np_err(np, "IPv6 is not supported %s, aborting\n",
+		       egress_dev(np, buf));
+		return -EINVAL;
+	}
+
+	idev = __in6_dev_get(ndev);
+	if (idev) {
+		struct inet6_ifaddr *ifp;
+
+		read_lock_bh(&idev->lock);
+		list_for_each_entry(ifp, &idev->addr_list, if_list) {
+			if (!!(ipv6_addr_type(&ifp->addr) & IPV6_ADDR_LINKLOCAL) !=
+				!!(ipv6_addr_type(&np->remote_ip.in6) & IPV6_ADDR_LINKLOCAL))
+				continue;
+			/* Got the IP, let's return */
+			np->local_ip.in6 = ifp->addr;
+			err = 0;
+			break;
+		}
+		read_unlock_bh(&idev->lock);
+	}
+	if (err) {
+		np_err(np, "no IPv6 address for %s, aborting\n",
+		       egress_dev(np, buf));
+		return err;
+	}
+
+	np_info(np, "local IPv6 %pI6c\n", &np->local_ip.in6);
+	return 0;
+}
+
 /*
  * Take the IPv4 from ndev and populate local_ip structure in netpoll
  */
@@ -675,41 +716,12 @@ int netpoll_setup(struct netpoll *np)
 			err = netpoll_take_ipv4(np, ndev);
 			if (err)
 				goto put;
-			ip_overwritten = true;
 		} else {
-#if IS_ENABLED(CONFIG_IPV6)
-			struct inet6_dev *idev;
-
-			err = -EDESTADDRREQ;
-			idev = __in6_dev_get(ndev);
-			if (idev) {
-				struct inet6_ifaddr *ifp;
-
-				read_lock_bh(&idev->lock);
-				list_for_each_entry(ifp, &idev->addr_list, if_list) {
-					if (!!(ipv6_addr_type(&ifp->addr) & IPV6_ADDR_LINKLOCAL) !=
-					    !!(ipv6_addr_type(&np->remote_ip.in6) & IPV6_ADDR_LINKLOCAL))
-						continue;
-					np->local_ip.in6 = ifp->addr;
-					ip_overwritten = true;
-					err = 0;
-					break;
-				}
-				read_unlock_bh(&idev->lock);
-			}
-			if (err) {
-				np_err(np, "no IPv6 address for %s, aborting\n",
-				       egress_dev(np, buf));
+			err = netpoll_take_ipv6(np, ndev);
+			if (err)
 				goto put;
-			} else
-				np_info(np, "local IPv6 %pI6c\n", &np->local_ip.in6);
-#else
-			np_err(np, "IPv6 is not supported %s, aborting\n",
-			       egress_dev(np, buf));
-			err = -EINVAL;
-			goto put;
-#endif
 		}
+		ip_overwritten = true;
 	}
 
 	err = __netpoll_setup(np, ndev);

-- 
2.47.1


