Return-Path: <netdev+bounces-192701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE618AC0DA8
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414A2A26755
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F1228D8F6;
	Thu, 22 May 2025 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bui5Ess3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9FC28C2DF
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747922823; cv=none; b=r/VeNis1I4eLkr1jEeUONblvueCkV7E8auaIUFkgD6stj4e9FW0cpP5v78jvwxi5RAOp963WwVv5oRe/+9RinbYPKqVXFUpyZ7VGq4k8p/RhGvcXoR5KzoTCDatIy1KfIzX/EwpVnSS8V7pJPngZVSNJmtSOrdeghWJg6px0B+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747922823; c=relaxed/simple;
	bh=Ox0MtGkzh3nh7CLtFL5qX0KHPLfrIGtHILG1V0i/ZZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWS84rRKNSr0BjqHIQnk02ScgV+pOzEXEqvdL1FlnhmQz9CZpneee6Jxjx12vjSLkZvr2OsTezVfKdMpvgHE9e9BuyVhvtS4ovjBQ+vZyg4vYsnbBPQsBKWLotA5+JSedLkZtvf2do8FTXgx9HE9uupODmxoy41pP3BekpY97no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bui5Ess3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a36f26584bso2824170f8f.0
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 07:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747922819; x=1748527619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuVvTyh2APuGKpkLmwx6DA+/7wBgxkM/Jz4/PX6rhhQ=;
        b=bui5Ess3bG0U4OwnHi1Hy4B9NYd2imqTM/Mtc6GAKtmAOWdFSZUHDUS7tnbCkjj0c6
         IU3hJzgcFGWdvsgj1ZBTzYSVDvzXBEaG/LLCLYz4/H1lxQAKU1PE9vcO8xEdQaIV/+7M
         rjpa2mjzmLLSkhYh1PO7VYHOfvlH5gpe7o/BVdZ+bNgjwlB3UEN1cUPvDAEVI3qy7SdV
         5FIPPIml5o6KFkVDHDCvpfXMt03iFgnq7Or8+0UXCkF4qK9SgBFoXZ6FhW/DFuo8UVgH
         eb7GrQL9GTOq6zqkx2td5AQDoKk9FbJp9zehdNGJGXzvQuj7Tkex+m6gARn1yZ6U1MnI
         TXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747922819; x=1748527619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuVvTyh2APuGKpkLmwx6DA+/7wBgxkM/Jz4/PX6rhhQ=;
        b=XN7y2EPgXjFDEsoQo+52r5sbYY0cb9K4xmQOsyIlOWAlzb3GMaEMbXoEy5i+fzz+eX
         C/XSxz+OadvZNwN4S8iovOms7L0eY6SCeYbVVMFqaapUzHgL1hZkGbOceUHpVBkFPi8v
         jkbzSSKQGvqbfMnR/lpGjfr7gx7sA801cqlJqFM9ungs8Ljckyh25S/qyrwPJanhT7r2
         y8ltf7AUHqUh9uNsPqN11Hw55xWQ2uItOx0JOszenWvdX0jHBr4j+ewwAuQGcFXl8oOR
         YfggS6DVRuTJUJMcUY1YdaPvdzgqoeYPNLs9rUjmoSkIujOUmyc6F9qFFSr6cyhnWhpK
         F13A==
X-Gm-Message-State: AOJu0YwqSEGbzq0R1ZZ/w3tnR1pIa4xuxoi9dXG4TnPPAWpaKu2+3AqT
	vKMEGCyX4Ia6/z57OkikwhiutlOQyCAN/TljRl6vs/XNWw/8X3MlhbjQLJWUxW+x6oUQt4iys8Q
	cmbmJaPrWfARfVOTSyDZAlaR0OAJ7IaHivS7YQbBpe8NG3rruFmlCvEoyTVJpoOI6
X-Gm-Gg: ASbGncuYC95oXMLs3SmocwHJFUQZgwWr62/4C26lNDmMEYrgIDYA/e6EpfgLa2OfxuK
	P6fUH/j9DIRms3Ud2VTy1iSNZTZ+uwvdUK/GaZ+HeC5vVJoO9OiCGAlKo6bb3XSXTknz/6cqVRL
	QwkGjMZ5RC/8VcqWN8PLEp/bcOH7G906bZiQKiSqkJg19XjKZBeKIHTaMfYwiQqAnx6Y76p6VAC
	/Gu7+5IQDCyvfmpzEZZpWGKl5yS97wEogZO2jQva7OGDGl9QYtOeLePBYKXGy+TXVoPiRETVCwS
	zOd9pMQ0B9WzjBsEpuj1ulOuxR4lUPWr9QxRWKJqJntOFB2CfXfWgkSJ+mUOT16JfQonoYACZ7Y
	=
X-Google-Smtp-Source: AGHT+IEm/7xSYbJ90mCkQ8TXGtVVFm8gZGbjxqysmTCYibf2Zhgt5bI6K5FnvfybHycu/q6lLr2i7A==
X-Received: by 2002:a05:6000:1c5:b0:3a3:648d:d0c8 with SMTP id ffacd0b85a97d-3a3648dd1e5mr16495338f8f.13.1747922819284;
        Thu, 22 May 2025 07:06:59 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:3ef2:f0df:bea2:574b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca62b1bsm23671269f8f.53.2025.05.22.07.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 07:06:58 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 3/4] selftest/net/ovpn: fix TCP socket creation
Date: Thu, 22 May 2025 16:06:12 +0200
Message-ID: <20250522140613.877-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522140613.877-1-antonio@openvpn.net>
References: <20250522140613.877-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TCP sockets cannot be created with AF_UNSPEC, but
one among the supported family must be used.

Since commit 944f8b6abab6 ("selftest/net/ovpn: extend
coverage with more test cases") the default address
family for all tests was changed from AF_INET to AF_UNSPEC,
thus breaking all TCP cases.

Restore AF_INET as default address family for TCP listeners.

Fixes: 944f8b6abab6 ("selftest/net/ovpn: extend coverage with more test cases")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/ovpn-cli.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index de9c26f98b2e..9201f2905f2c 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -2166,6 +2166,7 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 
 		ovpn->peers_file = argv[4];
 
+		ovpn->sa_family = AF_INET;
 		if (argc > 5 && !strcmp(argv[5], "ipv6"))
 			ovpn->sa_family = AF_INET6;
 		break;
-- 
2.49.0


