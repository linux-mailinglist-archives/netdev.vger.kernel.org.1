Return-Path: <netdev+bounces-181713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F930A863F2
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A44189F772
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB312230987;
	Fri, 11 Apr 2025 17:01:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F152221DB3;
	Fri, 11 Apr 2025 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390883; cv=none; b=swN36PzXqvZFhXNKhZl/63LFeWCDHzTf2TxPW72GTJYAb1dKtzzpcmXxxbOxs5xdpfQxlH6yy8CgLRHtx0yIXk/ESMn1O04PznVyJq6JlhNWq1D7yRF/g5LTYyQL/WB5uM7iXlh9RKygst5sQ//oL9sJIkUiFAcB56bJlZoQu2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390883; c=relaxed/simple;
	bh=YhXmralQOtAPpYDtC4QwLXoEtDNTsD8hV9YQs3fVBoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R1deU/vsLZNL8Ej5ANkpTkn2DEvOFHkxI4BgQH+VShT3oot0HU86Bgj6gD0OyoH8tTk+l8HF6oESRf5Ck4hISvod8X7RbQs2VK1SwuL51prmuC9hwIIngrhhP9mbNamALsV9unYIzO9gBetr369x2Ov8rGvzKc/YB2XCSB3OHCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso421084666b.3;
        Fri, 11 Apr 2025 10:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744390880; x=1744995680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nf6NpfxcWpwIeuGgKz1e73pornpa+ar9renqStP+qw8=;
        b=dc7KYOHUh4YrNkhva1/TQADBqAhTMS7fZrodlb3CUrelijaTpxqPV0QXI954wmM5zd
         DExpvNWfWhE6YooYcmrwiO7DrahYWOMnhhCyVB5aeML5VRM8rAUTsmOnFWPzJduPPww9
         7phzf0S38EEpSm23UtUGkOCwuRgDpFc7lo1/jP1RSy4w9HXRsGxJGFUhWh9IiQsLQvO0
         CeBeBg+kkm0QLA/M2a233n3D8u252OkZPaayuhoo1Dwlg04jzSx0rbz0C8EVFfG3cDuW
         m8f3n/7NIt1GLaVFWOI05eCmByeFYrF5I7CfZlyEL83hk5+taBkBdXWIQrEcPklXTkc8
         E//g==
X-Forwarded-Encrypted: i=1; AJvYcCXSdCSm6BVbGB9F6pkIvh41b+cwUyCpERV87tTz9veu7RUzwH2kKwPDGbfhIhlSEFPe7lH7qDAvfSeam9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUSsKslrw2wnPB5oWfMZBCVQbuLsWL1qMSreo4H5o5D7nn8pK3
	e+X7bVRiRsjuy+HURwKo+Gx+FotcW04U8wKN5cRtoVxJoo1W72JH
X-Gm-Gg: ASbGnctiJuiCC1skMtZHeTLy5Pc3hDoiGAAPAzJ83MkmpuQgGEMZb8qAn5lLWDhGZxc
	gExxZdtyiFbj/wN7lTJ7XVETb9tlH/UqZklC4emyilf8BI++9cMPfrBchgbh9cucmr3rXGtkFTt
	Mf2J/hf4QmFL03W86HwE7Bhd6Km9kmctgGA7rmgBshtwVoFCHUJGm9SBzq6sWuEMD5n+2ftxEmE
	FGUVZIvQi96Tggkd/iSswK3ihfFA9KomzKf+mYfQg5TmQWYZlGwUZlMTGUp2hp80sSPYAjTDsEZ
	sS3Puc8VU/msbEmBRR8yZQGCKGgflAg=
X-Google-Smtp-Source: AGHT+IHieN7cXEy9VQy2JMQ5xqz9oZqORh59JNBosqXrv6VH6DH73K16LG7PwMUgyjFlpVqQ55Fq5g==
X-Received: by 2002:a17:907:9496:b0:aca:9a66:9a2b with SMTP id a640c23a62f3a-acad36d93e8mr294702366b.55.1744390879980;
        Fri, 11 Apr 2025 10:01:19 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ee551b3sm1195429a12.5.2025.04.11.10.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:01:19 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Apr 2025 10:00:53 -0700
Subject: [PATCH net-next 6/9] ipv6: Use nlmsg_payload in
 inet6_valid_dump_ifaddr_req
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-nlmsg-v1-6-ddd4e065cb15@debian.org>
References: <20250411-nlmsg-v1-0-ddd4e065cb15@debian.org>
In-Reply-To: <20250411-nlmsg-v1-0-ddd4e065cb15@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; i=leitao@debian.org;
 h=from:subject:message-id; bh=YhXmralQOtAPpYDtC4QwLXoEtDNTsD8hV9YQs3fVBoM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn+UrUUCGu1LDut+UaNrtqlswKL4aFTKq9Ls2Qs
 NvyAR0D1nuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/lK1AAKCRA1o5Of/Hh3
 bRvVD/9lZM0pCx3p9i+vy5r1f7yyO7KCNWYqTvo2IMwJxeBXEILHy5fV62MEMjCCdtP9BYpaum8
 qEKQhGOFqw69n92o5cHE7Qo0MfXOMu0IOgGqgGDDHBlQqN9Bk6J2pakOnakCW+FAe5UhoN9FbtB
 4zp76kP4NImKZ+agzooBQjampKVpzcY6HYx3obWp3iEABCUDWz6M5lsmBPJtAhMCP76KgZO07Mo
 rsoVRkYW1uC5EZj7hPxeJuSzCnUzW899ISd0gd3MGVlxycvIri+3r3zJg2XYqRnCe+jUwwthTfP
 /6zaAVCssHpIdjKXx9TOdO4H5dsE+pT1xYnOLc4uiuehCa6ypURii/AmrV0ejNSYp2D8kO/Hjm2
 J34Vf+BnQIeJ8b45e1pUfcyLly+g44Ff252+4BlCm25Euu0qrHXrRnntNiZo3qT76ueYepsWC6t
 7iOU0caFnWt+mTY/ZqJUtRSb5KlE4GwpJNFZ9ntvdypNnW6ztQl/uL/J1d+lFrQffnneKPhMmwI
 C4GJ/wEJ4dLgH6XRKzukhSQkd68sS8mvuAb63lQ9gMS2WqoDL74HpVm3G9XFHNO3G4SxQFzGPIG
 xlhsqg0JUfh+QLblWhmEe3uN+dsxllhUHZJmgipg3yz/okNj3U7z5pKCHVHbRvG9NEL24FNLbLV
 gmpKZtxqhRyszMw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/addrconf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 9ba83f0c99283..a9aeb949d9c8e 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5346,12 +5346,12 @@ static int inet6_valid_dump_ifaddr_req(const struct nlmsghdr *nlh,
 	struct ifaddrmsg *ifm;
 	int err, i;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*ifm))) {
+	ifm = nlmsg_payload(nlh, sizeof(*ifm));
+	if (!ifm) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid header for address dump request");
 		return -EINVAL;
 	}
 
-	ifm = nlmsg_data(nlh);
 	if (ifm->ifa_prefixlen || ifm->ifa_flags || ifm->ifa_scope) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid values in header for address dump request");
 		return -EINVAL;

-- 
2.47.1


