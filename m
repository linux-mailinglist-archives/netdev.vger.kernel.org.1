Return-Path: <netdev+bounces-242209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1451BC8D76C
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF123A9C0E
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 09:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D2F3271F2;
	Thu, 27 Nov 2025 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2ZplBEM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2AF327202
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764234897; cv=none; b=k+Reh3zFiq7YZ3l9g0hAO9b073wAr4KbyR6txAA/7CDtZmyDpMy4Dd0GkKdz7hVd+8/hIpwuBmecgb0P86kJ2afDMXNIgW9ausjlIX5I1NXP4VTOGcmpqgYegx4TWJNIBBpK2ayh6P1uTlqZuN8PxejGaO77gSV6VRcc8cJ0jl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764234897; c=relaxed/simple;
	bh=cgHpqrZbI7wadn/9AB8KDZigrsTNXpK3vQS9cFm+Ukw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ay/jK9Qbx5y1wSu96Ve4EmbdyovRfUjGeC1obS7doFRKH+GAGb9q/SuNFBlwe/IUyDRp8xLZWDrPrbiw0wl+p/7hoXtzIQorsgoBZAh5TngeHUJjr0uqJepjxuEgReI0O2efFHJbphbs2IjCmlteZwlTOt3C0ntmSV5cyBKobRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2ZplBEM; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-63fa19e296eso78327d50.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 01:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764234895; x=1764839695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iekvLV4GZhbQrqzl8gpCeak19Q2/nq+IQ13jDYga+c=;
        b=c2ZplBEMns+eqGykKV+Pp2MzSAKXuuEFMpNUQzS+CC+k2AzwHWS/J3O+G9I5vUIWif
         pP5Miy0OUQz6gvWh0c+lCUgZx1vFcJ4QpZ3Bip0QIrRBUffVsfgsVxVLQVKhsIVf/lZ2
         ZxmU4GRa66uX8xaXybfshziVyDJdwg216LykWGap2aVNZSQMsZ51lESaasT8bDeFmj3w
         padi25QoL5zuPodqRqeXf6fVsOokcnOFi7b1btIagW4XXn/2cnlSYXWcU6U5OqwvoFlR
         8d+G7MwVkV6pzgP12gZr7Q/BJZTXy/aIVy/NbG5oqV7xAuaaKpfAaayx4z17CH2PqaRh
         oQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764234895; x=1764839695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3iekvLV4GZhbQrqzl8gpCeak19Q2/nq+IQ13jDYga+c=;
        b=tQGHvKJ6gKmL3rnNxQjlG0Uo4PNgFPw0j889RsfWQ/aYyWR/afdkdd0y0k/KToGuLE
         nt8ncIF9r0qi3hYosCBw8MHQbifpcS6oyM8A2Nag58zkSGSSrue+BKNMJveheLZDkoWr
         ldQ4B72zABBszXzUrzPfyC63jvlUjMOVOdq1XAwEJA5HCipVJq7U3Oab5yk7q43KT52g
         AQTbbe/ZyWO0gXhtN8Df2oa5vXZXssXaDaIjVOFSTKAObcXfFr9iUjcq/WlJsTu/q1A0
         XcWP56yF80YpItbpNlsMShDAY8QofdeovqK/JmzMJFmm10VuxloG2DFnk9CeUT35s9TB
         izKw==
X-Gm-Message-State: AOJu0Yyz7FTqbWWwOyoK3hJo0lptFY7bxv6VxzZqLsE0Efx56DTeN76p
	PfVh0nvXvewLuVnemgVImlkH3b/f0EG+N1ZCzFfB1H2ESExEAMBlgIA16orztRel
X-Gm-Gg: ASbGnctouoJxX2QOxnLNXdoBIcviZH4ZJ/4cOyKyytcIM1SAuVRoq0xfVcrf6C3Svkd
	vWwxqUw4efjxt86lJ2VtkkYCDB6qCzPOdoUIkbGZXVb8jPQfFsuI2Cpg1SCLmCO3LesA+lYo/vx
	39ARZ7qidg2zjqMmTWe3Feq2eT0gxDO+s649qDmX/CwE/x8qjewqsENdDnk5z3/2YJxyrRiCnco
	vYzlQwqdgdmpsg9eLuRgXgOp4oYTygfNlp+XrSTu+k4ASlAHGDl1mDiscWjaDbW3tmQa3lFZSGa
	AmaAjNu4WmD1RAxLIddFSh/FjhaYAkyICQpdsRjkzBbJQPZJz6wtRlExES6IwgFA2tCq9Xpg08c
	PzHINpzAmhpAQ1eeQXrieEWb0xnESxNmkPOD4AKX4AWL6AdUn3f4LLXUjZI3+zvYV03iI6Z8EFR
	33dqFY1aFn
X-Google-Smtp-Source: AGHT+IEr5JkFLPfjdgCyrCavk8W4Izakf54mFY1zsnd6VXjAobrhtuUcJCxS7doA1D6JXz9uD/g2oQ==
X-Received: by 2002:a53:c04e:0:20b0:641:51:ede0 with SMTP id 956f58d0204a3-64302adf399mr11135340d50.4.1764234894767;
        Thu, 27 Nov 2025 01:14:54 -0800 (PST)
Received: from localhost ([104.28.225.185])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d3f5bbsm3796167b3.7.2025.11.27.01.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 01:14:54 -0800 (PST)
From: Mariusz Klimek <maklimek97@gmail.com>
To: netdev@vger.kernel.org
Cc: Mariusz Klimek <maklimek97@gmail.com>
Subject: [PATCH net-next 3/3] selftests/net: remove unnecessary MTU config in big_tcp.sh
Date: Thu, 27 Nov 2025 10:13:25 +0100
Message-ID: <20251127091325.7248-4-maklimek97@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251127091325.7248-1-maklimek97@gmail.com>
References: <20251127091325.7248-1-maklimek97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes the manual lowering of the client MTU in big_tcp.sh. The
MTU lowering was previously required as a work-around due to a bug in the
MTU validation of BIG TCP jumbograms. The MTU was lowered to 1442, but note
that 1492 (1500 - 8) would of worked just as well. Now that the bug has
been fixed, the manual client MTU modification can be removed entirely.

Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
---
 tools/testing/selftests/net/big_tcp.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/big_tcp.sh b/tools/testing/selftests/net/big_tcp.sh
index 2db9d15cd45f..b5d9145296d3 100755
--- a/tools/testing/selftests/net/big_tcp.sh
+++ b/tools/testing/selftests/net/big_tcp.sh
@@ -32,7 +32,6 @@ setup() {
 	ip -net $ROUTER_NS link add link2 type veth peer name link3 netns $SERVER_NS
 
 	ip -net $CLIENT_NS link set link0 up
-	ip -net $CLIENT_NS link set link0 mtu 1442
 	ip -net $CLIENT_NS addr add $CLIENT_IP4/24 dev link0
 	ip -net $CLIENT_NS addr add $CLIENT_IP6/64 dev link0 nodad
 	ip -net $CLIENT_NS route add $SERVER_IP4 dev link0 via $CLIENT_GW4
-- 
2.47.3


