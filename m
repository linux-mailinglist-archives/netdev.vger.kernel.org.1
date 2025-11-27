Return-Path: <netdev+bounces-242282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5152EC8E475
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027863AE33E
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F15332907;
	Thu, 27 Nov 2025 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elVLvy/x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC823328E3
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764246931; cv=none; b=Ql4ucyzzvuryRtEFf39lCatNEuX70JhoNTLy1sycYmcy06olIuTm3efsuYsfaXIxdT+bjnTjnyItuIl8RGifQTVidoCc7i7WyWL8yzdQpCA0Pi7/gE8VJPQW84oTkQWU1JkLcfv7Fa4ls0L0CTVngmjInDilmWPGs8AVQ0jDMIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764246931; c=relaxed/simple;
	bh=SDD/uY9lDrnQ0wCJ8W/3GAz+Ix4zBrgPCC/2BlbMuWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdXMG0lPPDU0r/1mtGWQIm3RZ8L39bo+JUehL6Jyli5GKyUFfCqBq+kSBdBcVsuX+eINudZYpL/0Ro7qADAkCMaY7w/+9DuzvU/L8olAD7sSl/k6pfjjJNpfZJ+/yg2cioNwUHXxN/SIBNevO0DRIO5K7pmpgymUjYf8zUSqxZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elVLvy/x; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b3669ca3dso405618f8f.0
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 04:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764246928; x=1764851728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ngQqzbRobx7rR+xWDwzr0ZNj41Wwc2wJJl825y6NO4=;
        b=elVLvy/xr8RypNkflJAKHJDSMoqMJ5TA+6WbImw9z807aJxkpbBzlCQ5v3xYkAuyUh
         29fU3J96Y3bDt0z9ykgB8ljiwe5SsVVgyGW8xezMTeVUpjXCSoURBM16KMVI8isdywTE
         98Q3kcIDi0xeZKugC+Scl/aJn+eLBg4+jbTVcNsizTt6dxhAtQ5zlIZ8uj0q32tcvZRK
         cKiYnfb4ZaRm8Yo0wFBFKk2rqfnIx4xlpsXOiQ4ZSYRZOE/l3zTFbDUgRs2RuIMngq4+
         mQdvBe0eXdhr1A5KHRy6m53YRskRSjBbGYC0bLzBdSOUU+V1TTBK5iTd8ZGOMR/n9Q+Q
         5EVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764246928; x=1764851728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ngQqzbRobx7rR+xWDwzr0ZNj41Wwc2wJJl825y6NO4=;
        b=Y8zGpCEedoo8xLQ7xSGRpk0GiJEpjToxXHwPsq3uSCZGUkWnw4oC3VmHDgxhZ0ObT1
         I/JWfM/qBcDPaHu9p6t1RgC1TcTTQL5Ttx1ASS4yszsU83rVhdMuk3izuVgwQmf9QRqg
         +ie0A/CAOcNJDlirmPzhyYwg+6z42V0A+zu5Ool7mahgGxNFF7jzbdRNO9y4vXuPbLWZ
         t+QwD4BbqXHyqMlHknQdDHBgDP9y1UZqkk+cj/tkcEl4YqXnDzrW5Dj1q43hEtH3H34u
         aMO3xV4C+tBPFJMGoXE/16+ZAdNz9yaplcSUvPxYxzOczvn2hWPzmusY7jdU4W1Njesn
         DZkw==
X-Forwarded-Encrypted: i=1; AJvYcCUzObvWqBxP3RTei9jXTRDkb+Rby1oTRnxV+HS0HZWuKi4/TCaVHe+zKKPbSqpfJ+0Gw+KFSf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5fO1tSM8waAT9ot6UDkCjR5ndy8kG+igcWzut43IOmVR/TDHL
	Mu1voRV+8DSmrA3/2NNp9xssyT4x9ReOnIQJeoVHfBF5aq3sn9n4gf9w
X-Gm-Gg: ASbGncsiVcNhkkAlDEi4UUVKuzywbjFOnPWwNF0w+eCgsKe7A/PG/mR1q3Oj7j/TdsH
	CP3rDEssXUGykHnhcPCa/ehSSmqXuqlAunpFexjrJQJPURZXShtR+8RRHvVcnfFjgkwmgaV4sQq
	4QKSDKdtY86bKCMX1y1pIm9wexeuX42YUbguD9wVAWG0Qh3VFDi9Hw4JlBUI9LfnbQblHiY+0+Z
	Ef5boaagk6kCABdr+S9N3OOg2Y1cAWhzrX0QE5ALnec0faEOBllcHeG3bUn3RC9K6ouBFVEpv5P
	aW5kilumoaTPKolfvkcquGX4yENadlLFMzFkfJ1Mu1XiCSkzPA4V70jp4fWmR8XAzPIeswWUR/t
	ed6fPi4hJv7ky/P2hnTbV2hoAHbjlCLrvGRLpCMlMDSr3MBzoBZI5sOOWADe0BSnDTfTWRRVmI9
	CkvxJyfoe3gAnipiQWVtZIx0qp9A==
X-Google-Smtp-Source: AGHT+IHDZdCE9vumQVh6zBHi/PT3YiBvMpxnKXGHwzuYsn+Ob/wzUHavIuCOpiqTfaA9TMZgdtVABA==
X-Received: by 2002:a05:6000:25c4:b0:425:769e:515a with SMTP id ffacd0b85a97d-42cc1d1969emr25100243f8f.42.1764246927902;
        Thu, 27 Nov 2025 04:35:27 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:7864:d69:c1a:dad8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca4078csm3220718f8f.29.2025.11.27.04.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 04:35:27 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Florian Westphal <fw@strlen.de>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jan Stancek <jstancek@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nimrod Oren <noren@nvidia.com>,
	netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 3/4] ynl: fix a yamllint warning in ethtool spec
Date: Thu, 27 Nov 2025 12:35:01 +0000
Message-ID: <20251127123502.89142-4-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251127123502.89142-1-donald.hunter@gmail.com>
References: <20251127123502.89142-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix warning reported by yamllint:

../../../Documentation/netlink/specs/ethtool.yaml
  1272:21   warning  truthy value should be one of [false, true]  (truthy)

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/ethtool.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 05d2b6508b59..0a2d2343f79a 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1269,7 +1269,7 @@ attribute-sets:
       -
         name: hist
         type: nest
-        multi-attr: True
+        multi-attr: true
         nested-attributes: fec-hist
   -
     name: fec
-- 
2.51.1


