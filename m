Return-Path: <netdev+bounces-283217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDqrHnHM9GkDFAIAu9opvQ
	(envelope-from <netdev+bounces-283217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:53:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C114ADBBF
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D014D301230B
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 15:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF643CB2E5;
	Fri,  1 May 2026 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="a/OaqmS2"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACA4308F1D;
	Fri,  1 May 2026 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650796; cv=none; b=Xjb3f/0B/XPwvGQE3zm4ragImX1HurSYbOVOF0PjHb/ySSjendsVspNswI7EosjzPHz3o5knA1S49vNiKPwbSQLD+/5JiLeLH4Xck5XdeS0p4gM5+4d1nMNBn3jn5oSMp4DAK9liucjDdgKYB02Ycz5jShzvE5C/s3+yWBkfZXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650796; c=relaxed/simple;
	bh=gduIzX2COqKi3echiOqVyeGo3D7A5nRe5hkExoahJTs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pciEr/1B1HDhp/S8rtW7mOFxZdP1dt8DL5ojtSCg+JIJrsjlUJJEeNvkkpKLKqm7CZoKbEr6tHzyrkOJvvrKNCECKQ0Pm0jnyALOibP+DT6iCjBcP44/okE1XgS4rSeXydrR+KU9Zk9DBBO9/9e2Ks9mEHAfcA1aMWY008tPq/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=a/OaqmS2; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=BM9TRss7pseX+5KsnKhBOYrrt8MuhcUMHzPX/Gdxhl8=; b=a/OaqmS29DgdUZ+aj09+krWGZx
	1HPWQJKqJ8e5e0XH/Kk3NN5InLgYmcRGRDVtEnKQZEk2jtezUctodg6txSNpA8jMEW5LADC+yl1rG
	TymrkAdJCAvTz4HbGczLkcu91r3VLnC0aKaqJ9s8/KYnRtoZzAWfsh1JzCC09DVQnYFr6jUZ5rThU
	h1yaF30qVChT2nFx4aU0QBJsBIjkhfUpo5dMh+a+KibRFll9UaXsCuCw9sR860N0cT4zgp8VG2DTN
	bURcwiPIvmQgjfDeFUrPIV+Y/ER+/HpVZw15Dbhh6G007oS4yMm47ZKMOacgJrNd/1LJ+UBovdLnp
	L4hGsMxw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wIqAt-008gXm-2X;
	Fri, 01 May 2026 15:53:08 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/3] net: Convert AF_NETLINK and AF_VSOCK to
 getsockopt_iter API
Date: Fri, 01 May 2026 08:52:50 -0700
Message-Id: <20260501-getsock_one-v1-0-810ce23ea70e@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFLM9GkC/2WNywqDMBBFfyXM2kAMvppfKSIxHe20ENvMKIL47
 6WtdNP1PfecDRgTIYNTGyRciGmK4FSeKQhXH0fUdAGnwBpbmdLkekThKdy7KaL2la3Lxp96b0v
 IFDwSDrR+bGeIKDriKtB+F577GwZ5yw424XMmJjkOv55TfzUSTN1AiUU39VD5ugi2QOOWHNp9f
 wFx1vt+xgAAAA==
X-Change-ID: 20260501-getsock_one-a62758a9ba25
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 sdf.kernel@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1362; i=leitao@debian.org;
 h=from:subject:message-id; bh=gduIzX2COqKi3echiOqVyeGo3D7A5nRe5hkExoahJTs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp9MxeFq/D7jFqIv11BP6BM9zPkXhUVb4scptVj
 6kq7ZILtcuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafTMXgAKCRA1o5Of/Hh3
 bT8mEACrZTYte2TN8LU1uRVgKVKEPcHdCbkK2gAHbwefeNmAv9ubMeaeb4YzPlRlf5Lj2TR5iCn
 D8VeM9NzxdRnUoQt3RbEjA+JcFxek8N6VCCiq6ih0pDcmp+xaxaECNJxUPGX1wb6QD22d65x9Ty
 hkaB83VIa3lTLflpSd55xhuCmQLCh1/rua34UdxKrJc5fcHAj03xjS/wsT5VAPyJoWvRGh03Iqx
 z4n1RiKNnnlVcOPzZC21GnOtIgvZGR7jPeVoUZPrrTlePdGHkp0KzmLiO9hxGtkn8A4GQWDCuZ2
 24bQjl9HfR+qcKs2b/DoFeNAT7aPEzW3qMaL4yN7ohnOsYLAcMPgj0ZIHTWasKYlFze2RuEMeIk
 +ytbjV1MSJaTEJlN1v3rvWMrtnmE8jvfpImfhC54ZksEjBl7JdBcJvIjZw3A5qZqZW+hrDSUf/G
 B1d5BfuDYK5xkWOsP0XfvbSBzYBNFaVUosd21BSoe6rczygT2XvLCEYO8sAjisBAsTZho10PRvw
 vtlKQr5N5BKSBplDmaiS9bZAVIw9XS3Qg0oOapz7rlCg4LyGMPt7vho0rO7g/q4GkyCojotZNf2
 S3z10H6L5dFFGp+Fie1z9TOUy+iRQfk/BfcUqD+8I5aePo0OUBLqlIEOszeiW4+M4Ee9Lbo+CyL
 GvkA3kX0gRlmllw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: E2C114ADBBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283217-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Continue the work to convert protocols to the new getsockopt_iter API.

Convert AF_NETLINK and AF_VSOCK getsockopt implementations to the new
sockopt_t/getsockopt_iter API, and add kselftests that verify the size
and errno semantics are preserved across the conversion.

I chose these two socket families because they are probably one of the
most used  protocols,, ensuring that any potential bugs will be
discovered and reported quickly.

The selftest was added as suggested by Stanislav Fomichev in [1].
Link: https://lore.kernel.org/all/adkSnyihmD1Atfcf@devvm17672.vll0.facebook.com/ [1]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (3):
      netlink: convert to getsockopt_iter
      vsock: convert to getsockopt_iter
      net: selftests: add getsockopt_iter regression tests

 net/netlink/af_netlink.c                      |  21 +--
 net/vmw_vsock/af_vsock.c                      |  16 +-
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/getsockopt_iter.c | 213 ++++++++++++++++++++++++++
 4 files changed, 232 insertions(+), 19 deletions(-)
---
base-commit: edf4bee4215a173c0534d1851d7523d827149f9e
change-id: 20260501-getsock_one-a62758a9ba25
prerequisite-change-id: 20260501-getsock_iter_first-87f6a74c24e0:v1

Best regards,
--  
Breno Leitao <leitao@debian.org>


