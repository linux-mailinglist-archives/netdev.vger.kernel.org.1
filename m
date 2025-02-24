Return-Path: <netdev+bounces-169153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 965C4A42B25
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B7519C2EB1
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B57265CC7;
	Mon, 24 Feb 2025 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rl95B2IT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BB2265CCB;
	Mon, 24 Feb 2025 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421185; cv=none; b=qMIK+X8mEXr+sd1QnIZNfzmaYaOWAz5PAsFo3wgle3vnTfK5HCcjymOTe+EgqfpciTwj/tjHcDZiJSULPGy4yPEHUtUi5azKAbyac2FLqNpEFJxGzykfDnOLB7yVeRdgDxbeN9FzDo5KoWPAOm1EG7n2dTFr2dxm8pzhiJdGZ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421185; c=relaxed/simple;
	bh=aOpTiNZ4UTpq4GD/D/yo0qqX81+gFPuHmfJiBAbK3MQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=srAcSIYf0FpYzLXlfYZWxcs/clAd/+jW37xUwJEotl4PObFR9FLSQm6DSIuxxZoQ2xLbN+68epYlFlZTq4ljtkV3cl97hfT2ezrdffagiSYPIPZFsj7TIqck0VFcEjy+dHzxJCoZ6m+7O6qnQfH08PxEhWK6cEtE9AOeENzXOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rl95B2IT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012EEC4CEED;
	Mon, 24 Feb 2025 18:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740421185;
	bh=aOpTiNZ4UTpq4GD/D/yo0qqX81+gFPuHmfJiBAbK3MQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rl95B2ITOHzPPIZEYbmMq41/UD94NPfW+6HKhV8S6qH+goXyzLp9dOGu2tHZj3FIC
	 izZF6fi3TP8430/x/Rm5Lc7cZJth30EJMGbucf7kxM27mGbXVxTz1ZP7tg+H92//OA
	 jJuEjT6afOMHY/5Yxh7F3Hckc+MPm6Sn7vtJFHvs6JCSx8UHzP70RzPkNcc3cxJ8Po
	 qTQ+loH3rAy5CbRToQWS1DRSNhgpbjUHgR+K5tWOTm85uB+c2tYMgri3oHXZGTOOQ6
	 x6W3fAWZKFnXGZM35Wye89ws3p0XxjwP9xfrSX9Z8hzNsGLTcqVTZrsZv8DbLTW1Kg
	 j0fjSK3tlQFsw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Feb 2025 19:11:52 +0100
Subject: [PATCH net 3/3] mptcp: safety check before fallback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-net-mptcp-misc-fixes-v1-3-f550f636b435@kernel.org>
References: <20250224-net-mptcp-misc-fixes-v1-0-f550f636b435@kernel.org>
In-Reply-To: <20250224-net-mptcp-misc-fixes-v1-0-f550f636b435@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=942; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=aOpTiNZ4UTpq4GD/D/yo0qqX81+gFPuHmfJiBAbK3MQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnvLbEGKhlFTAlo0xrvPENFUa8ZD2kU1QWhHNua
 ZIEQaX3b6KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7y2xAAKCRD2t4JPQmmg
 c1voD/9cqEQ+1y1c6VouIeNTM7UDiOdfkaJWyXPQTRrmJpYqraTb0kL/QR1sQJ1MpHazbkgsE75
 H2NfvDaAP0v+hnSR+5IjZoYRM96/D2aMLuo7BQk3jRmtSWxlZjD6k8OjX8v+AejB4zrpN7tC2TG
 vVmxaX1xs+bKLGgPz6ybC5uVfvKIL2wubnUNWMkEVBVdOX76tvPZ4jPEqcN0BHQuts0LzkQ88W7
 G26Pbh6ZK3v8/vYBUDARKQ9xA/mnQISWdh336gF3NvTDZOOJyERDdDMSyaVl8wdT9aEepyQp0sa
 WkL9ssuTqapCmCMzkzgWyvX5fyGfIj/69taRBrATqgDZM/reZk849ZKXhMB+38SagUdsQYtv0Kv
 00cgOXd2ZfReAzWIFHK+aylLY39XJN/UJGeM9vRrBZJr8zOyfgx7tlL0NpVzELkCBEP0licKKv3
 GBBcJe3ewG9aDCLWWq6uYmq/EBeyTejWgIdJ08tAAywbc/spUzyXHFOLhBUA9sV/o7w11DwRMUs
 UllDm5MYwcc7nSmxj48DwERKeazNryjR4yutkSqUtuP08iB+QXSR12lmFOKDLhoBTcid2Pi+Kp6
 6cH5cIEdZiSrMIarf9oQ8bv0HF+Le6bojQEjEFYJ5+VKmZ9jgfNuyucZeqScgBRqV0tkEJLDrF3
 MmiGY2zzjTPb8/g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, some fallback have been initiated, while the connection was
not supposed to fallback.

Add a safety check with a warning to detect when an wrong attempt to
fallback is being done. This should help detecting any future issues
quicker.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f6a207958459db5bd39f91ed7431b5a766669f92..ad21925af061263d908bd9faddffaef979f46c93 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1199,6 +1199,8 @@ static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 		pr_debug("TCP fallback already done (msk=%p)\n", msk);
 		return;
 	}
+	if (WARN_ON_ONCE(!READ_ONCE(msk->allow_infinite_fallback)))
+		return;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 }
 

-- 
2.47.1


