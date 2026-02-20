Return-Path: <netdev+bounces-259757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEMMC+atmGl4KwMAu9opvQ
	(envelope-from <netdev+bounces-259757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:54:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4DF16A32B
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C083303E49D
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 18:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB3D366DB0;
	Fri, 20 Feb 2026 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hf5h3Tz6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D7E366DAB;
	Fri, 20 Feb 2026 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771613657; cv=none; b=si0dTmjsb/UHdE0iNsLqSdz3Pgcj+iUP9jc5/ALOQNIJUbz2fWjltu55s3mYPDZurLdSvbnvKp85UR2LZrYzhislqofHRa0+ROky8RkgPGtlRE0o5beJEMfkuX0cW9u6HSEWXm4bdAyG9kujzvlg1uUA8iZvc0CltEc/BEnqde8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771613657; c=relaxed/simple;
	bh=VT10bXnZOZstjp5Z5qwmfPi+JX233sJrsM9ySP83Dxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ukr5VCu5vz6XZnbhddV7hBx8ar6Txmp94nHUKX+NYDqAP3qYJwozVSpSFgGajeGvNPsA9n85G3+3AmeH9ZVPlzhJjMoQ9I5XZD5SJVnBnTnsIBKqQvGtOgfkgYODAfHAfHvIOiUbtgyx7H5WRbjC1tOzmlqbysBH8XSy0OZHaj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hf5h3Tz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD83C19425;
	Fri, 20 Feb 2026 18:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771613657;
	bh=VT10bXnZOZstjp5Z5qwmfPi+JX233sJrsM9ySP83Dxo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hf5h3Tz6+sMQQLjbFBrnQcBFWC0SlXNRV7/ZmwKPx8SdCo0uH/vdIRzBc+DT7Pp9y
	 a2wEEoZbbUip647+RucobHmgI0g9IMZ/HGMS/RpnagkTkdkJTv3cadSJDXLT/82NPN
	 vGCqyZG4HARi3x0dxnEPIWJWhXeEdc3qI3Uiq5T629p4i0Gf82jZJlnaGtnD4dKw6I
	 +dePGqXTblVj1c4tPrky48oGqUZWwxn8WV8pNx2E5oGPZg6XD9BBSY32aDq8gOM7SB
	 b6o0Iq/iDhGrrSbUQGreVkxTBpb5VOwx4Vg4OSa/1dvT5H6lv0OTaUHerF/wFjWeDV
	 5F5u47e+m3qMg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 20 Feb 2026 19:54:01 +0100
Subject: [PATCH iproute2-next 1/3] mptcp: uniform stream closure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-ipr-monitor-json-v1-1-eb4b0d5f7820@kernel.org>
References: <20260220-ipr-monitor-json-v1-0-eb4b0d5f7820@kernel.org>
In-Reply-To: <20260220-ipr-monitor-json-v1-0-eb4b0d5f7820@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=917; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VT10bXnZOZstjp5Z5qwmfPi+JX233sJrsM9ySP83Dxo=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGmYrdTIGeRqWFY3yOeED5a6jA9m2fRAjZwlfr2z6xRlfcuMM
 Yh1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmmYrdQACgkQfCLwwvNHCpf31AEA9+5g
 w8WnKnsu/TFb5KAEF+wDUT70Z2ruCYR1aNIENfoA/i2pjaRb0MEYKlyQKCzT0DLv1mMUTqWD40q
 ilEs9444L
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259757-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD4DF16A32B
X-Rspamd-Action: no action

Use print_nl() instead of print_string(), close the json object, then flush
the stream to flush the end of the JSON object ASAP.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 ip/ipmptcp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index ec9ef62a..18ec05a8 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -273,8 +273,8 @@ static int print_mptcp_addrinfo(struct rtattr *addrinfo)
 		}
 	}
 
+	print_nl();
 	close_json_object();
-	print_string(PRINT_FP, NULL, "\n", NULL);
 	fflush(stdout);
 
 	return 0;
@@ -426,9 +426,11 @@ static int print_mptcp_limit(struct nlmsghdr *n, void *arg)
 
 		print_uint(PRINT_ANY, "subflows", "subflows %d ", val);
 	}
-	print_string(PRINT_FP, NULL, "%s", "\n");
-	fflush(stdout);
+
+	print_nl();
 	close_json_object();
+	fflush(stdout);
+
 	return 0;
 }
 

-- 
2.51.0


