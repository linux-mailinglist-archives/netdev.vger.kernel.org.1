Return-Path: <netdev+bounces-247338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1509CF7A55
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 10:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7202930321DC
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDC62DC334;
	Tue,  6 Jan 2026 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcfbOj9b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE512DCF7B
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767693235; cv=none; b=rjqY8rGdFqzrdg2HCcHw5Z/18bIEfg9o0KF878A1SJUcrJ44YCI205kJf1WdvfWbJPl7APKLW0xp8X0FgNn1yjkpFs19afMBo+C1Q3RulsO/ToKbK91XBYrth3YgetkilwpA0ZGqShQhgWGJf6lC6CrGw9M3gGISC4jWfRuj0yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767693235; c=relaxed/simple;
	bh=cgHpqrZbI7wadn/9AB8KDZigrsTNXpK3vQS9cFm+Ukw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ut5EXpCdtl28Y2L9ZoKaErOKzFzmGZSBRT4Vq7jxWqjIkT3ImiWf1V9ymFZJdrfUUA6jVoI/LlEbMM0TGIScynBOIswRQnbllaGrfnLV6rPMO/z8OBvl0bbxfQMu6b50GKB9JP/lqhs7SWIfIdd8Kkap4FJS//644SQI7YllBco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcfbOj9b; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-646d51949f9so118729d50.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 01:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767693233; x=1768298033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iekvLV4GZhbQrqzl8gpCeak19Q2/nq+IQ13jDYga+c=;
        b=gcfbOj9bBQhjVxq6rOHeBFixS2lKgbgrNUHtSkqhdVp1kNE0B/TarGwdyOxbOVQEuk
         iZG1jGA/9ViG98SDxyI52i40ZkKt0DMyPYRk8b8pZPYE4EXt9j3nP0bwIctvEbJhRcfj
         tC1UyIRaxN7qzgqudWgRFBXI7XjkvAOy0ZLdeqmsOsd6JCZC25zsjRzmeb4yUCSpsDEL
         Mm696InHZcH1teBjZ2vvTLDpuLQHy+PmZtP7abAr+K2ZXcxnkEkLuaD1G+LlaBGUYNAJ
         AjOlCjfjFwQRnuPOFaDwnAmhs3kk/WLGRjQxqsARCfavuHjEjPdplD+9QrTE40D/kFf+
         rfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767693233; x=1768298033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3iekvLV4GZhbQrqzl8gpCeak19Q2/nq+IQ13jDYga+c=;
        b=kUeVWrMoeLB7Gu/mYmx4+4yyr3ZnVeJMw+/iSOOpztQViXD9GrMkmy2PJfrXID1YDP
         ZTjh9dIpcNfAjeQBFzMstohJ+bqi+wV+uQVVQMtFlUVpP0uklX6ChBFJkfhaJmj05uwO
         znhz8l5LUtgmnWFfQSjFeH70zAUQVRLQRDfklADYRAqvBvklUBhbAvQ3+I/DDT0bbphx
         erlcQzjQC+b2dXhZllrk9CVYvI8HGLMh3FXjbiFYgJYOxUrtYNRYc7hVaXQAnBWgpzhh
         ukoQ25CLWpwqXAYypyn8S3Wr9tM42oh92wleJx+aF9gYRG5fxf5pECNELL5eSHaKU/Tv
         FdRw==
X-Gm-Message-State: AOJu0YxGStewnWk9NcwRhbYRn/4nuUNse6LxcSVKhL3ZpD4q3b4vbfM6
	l/9pupgXVhlcRw1zEwZ3KjSx8T5W0RqAIHr4hlIuE3eOfQZzmFxDPkSrCH0h0oK6
X-Gm-Gg: AY/fxX5frz51F75KaHoqfH0jgxvFfpYB23B/l9W0JEp4yPENkgBbCU1wZJuOclk6b0W
	fOLtbXORDRV2XdDvl9b0UQ4kg7s4mpmacENlz5nY8pr+dNpqK18fAX+1D/nqgx2oV+mZep3gp+L
	LlonNC9VAWSHhHw3t1GFX6vvEWn1uvOlb30hyAiQeI//FLbP6hRxCttuWf7/N9TrmSn/QFpdorV
	nUIRUxkXsTYh37zCL+ZLc3IA7AuD4L1hdSyLH0zsZiMOT2a1mlUZzY/hPYAX8gTbGZeSF3Pwmlo
	wn7Ajow0PHC3LN0MBE/jWpD356nnqrfJ74R0ldYRCGdEACOGXbvaeL9juokShRxROVfV55h9yOX
	MGEo2yqhlKEsIej1JqbcWgiCKuk08pxQuZlfI+Tz/I9VOo8uknuFZOoCDDP15ENafjj18LoXQGd
	WHLd2/CM7p
X-Google-Smtp-Source: AGHT+IF+pA+XttLWRt0kuz7a8OgK8dRMWTYeuM4dOp8lZasv3iIEzi9l5WUiA9h7nzCTOn8rtJM0fw==
X-Received: by 2002:a05:690c:e3cf:b0:790:4cd8:f507 with SMTP id 00721157ae682-790a8b5d9b4mr17929247b3.7.1767693232951;
        Tue, 06 Jan 2026 01:53:52 -0800 (PST)
Received: from localhost ([104.28.225.185])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6dc249sm5722947b3.51.2026.01.06.01.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:53:52 -0800 (PST)
From: Mariusz Klimek <maklimek97@gmail.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	Mariusz Klimek <maklimek97@gmail.com>
Subject: [PATCH net-next v2 3/3] selftests/net: remove unnecessary MTU config in big_tcp.sh
Date: Tue,  6 Jan 2026 10:52:43 +0100
Message-ID: <20260106095243.15105-4-maklimek97@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106095243.15105-1-maklimek97@gmail.com>
References: <20260106095243.15105-1-maklimek97@gmail.com>
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


