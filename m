Return-Path: <netdev+bounces-256437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WyL2GRFDgmnsRQMAu9opvQ
	(envelope-from <netdev+bounces-256437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:48:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE583DDD13
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A6DC314104A
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B3E3D6667;
	Tue,  3 Feb 2026 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9DxnDMu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4A33D6660;
	Tue,  3 Feb 2026 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144177; cv=none; b=lEp2KHX6AHN2vekvIX+LYYULxVgYZkt74ePQi2SOmu2iJ35J8M2oad2w/+pDqwiQbAUzxrMVsNi4yXMx28cdBEI9NLwOg1/0f+hRsaQM7qIZsMfessWw03Pe3RN46R3uR29hIeT+H0DZjLN9HB4LQiW169OH4qozdlIhPISVVuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144177; c=relaxed/simple;
	bh=QI7WRTwVSEM0XiF/j6mP2IUzraAerfechwCzPq+aXgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nb9FCF3GsN7V+CAtSUkdj4e0jFsN0abPhQ6FxkPRNNnmSbR+Y66awzjHmKgVPE4b1KDAJ+zF+dLuh0I5BgpeIpuWyrfBuIxUCiAJQ8sJj/TWX0w44BhozVxEnKGowBCzghKjNg8lpqZWTxFpcyB5uZt+EI2MO/iM11Dl7vguSfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9DxnDMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C41C116D0;
	Tue,  3 Feb 2026 18:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770144177;
	bh=QI7WRTwVSEM0XiF/j6mP2IUzraAerfechwCzPq+aXgE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c9DxnDMuKCjb2Wem+do7j194vFU9AM/mNZd9l0aXi264OhMD82UpRljYEtuY7LGJp
	 hKScInLcVuwseeRTud3l7LnJ5OXVZtT0hW9/qLSbxLaYF6iAiuchEx6RcRRL5Fgg5B
	 ChLV4oJ19cGTV3BP8ZJNIWLx1h+lGqzgWurzesLMUCo6uC5tKnqV/a4sVsRow3sdjB
	 AEshLovRLikzFSclPwK1BGpFlARUrIlsi8BHfKm6/jsTrD2nh90W/kO0vYS2Uz59Pk
	 OF9URbdIK5Kl3UMKOAJUyeUvW/iEiCxO/CW1MWlf+BR0iAN3Oo2t69eC5v8ztUVU02
	 TPkgrJj8Wcv+g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 03 Feb 2026 19:41:28 +0100
Subject: [PATCH net-next 12/15] selftests: mptcp: join chk_stale_nr: avoid
 dup stats
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-net-next-mptcp-misc-feat-6-20-v1-12-31ec8bfc56d1@kernel.org>
References: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
In-Reply-To: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1401; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QI7WRTwVSEM0XiF/j6mP2IUzraAerfechwCzPq+aXgE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKbHPuEn7xo2idsssJg/fzS2aKLm1iDj5xbbCCT+KLTq
 iYiiJO3o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCKXWBj+p+Ze29Z51N/E5oxu
 z4atXke991SLcS7PsXwiMpHl9g0mC0aGWV+vx8YXnzsT+u/w28V883kiS80/3D5/kdF+4XmP+Ln
 +/AA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256437-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE583DDD13
X-Rspamd-Action: no action

nstat outputs are already printed when calling 'fail_test', no need to
do it again.

While at it, no need to use the dump_stats variable, print the extra
stats directly. And use 'ip -n $ns' instead of 'ip netns exec $ns',
shorter and clearer.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4977e6ff17b4..a8b9782a85df 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1648,7 +1648,6 @@ chk_stale_nr()
 	local stale_min=$2
 	local stale_max=$3
 	local stale_delta=$4
-	local dump_stats
 	local stale_nr
 	local recover_nr
 
@@ -1664,16 +1663,11 @@ chk_stale_nr()
 		fail_test "got $stale_nr stale[s] $recover_nr recover[s], " \
 		     " expected stale in range [$stale_min..$stale_max]," \
 		     " stale-recover delta $stale_delta"
-		dump_stats=1
+		echo $ns stats
+		ip -n $ns -s link show
 	else
 		print_ok
 	fi
-
-	if [ "${dump_stats}" = 1 ]; then
-		echo $ns stats
-		ip netns exec $ns ip -s link show
-		ip netns exec $ns nstat -as | grep MPTcp
-	fi
 }
 
 chk_add_nr()

-- 
2.51.0


