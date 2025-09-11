Return-Path: <netdev+bounces-222336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31697B53EDD
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 00:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6EC567DA1
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F6E2F3C20;
	Thu, 11 Sep 2025 22:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYhBc1rQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500422F39DE
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 22:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757631509; cv=none; b=L/N0s8booTsOty7njQcQKuGkrWfJG8rtAC2LqRy2lK6Dy1rL3wuIyEj7eOn6K7sHQLse0DGyehLTapkQnqN0ROcRfMg+xDiDKXluS9kwUVZj6nxj3bXA8fLA1r42dhKKcQf7ZEQSyu4BJbIn9LjFhoeaJczF2lKSykeAdLfE2vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757631509; c=relaxed/simple;
	bh=0Duddb0GkVxMc51fG06LWjua3CZrk2jECLZXHnRhzx8=;
	h=To:cc:Subject:From:MIME-Version:Content-Type:Date:Message-ID; b=Q/OkMXKOigjEa+MdiYDzBPUI5hwKhiFrgUaB7KRV9tiSD1CJUVeq7E/kID9eKbNuya1HzrmH5snEkCLK64jU9PCkI+feVsov+AP8qLX7wEmILILI+kApp4RurgtsI/IKJyZK0tjtLraLANqsbayBhEAR66lq8SUWybPObsUJoNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYhBc1rQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757631507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UE3p0qtQ5K2A4+RW8M2HqTZuytmzSPCz5SQUWEcMJmg=;
	b=cYhBc1rQZAWwPolVeRjoBJA4hpIxt3nyTsvGQ+3s2nBYCmp/RjGB0KUtqY267fVDb+VQOv
	pXsadLcYqWhU4Z3thMmBeqLlWlKVwMPrWkE1il0CYbbDRQQYXg6+n6ZpbJWVdYMPY5b2oK
	CnuxTk29M7z3Kv94gacQhxMLklWHczA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-KRXhT9jiNMiP5RxYQ58tcQ-1; Thu,
 11 Sep 2025 18:58:24 -0400
X-MC-Unique: KRXhT9jiNMiP5RxYQ58tcQ-1
X-Mimecast-MFC-AGG-ID: KRXhT9jiNMiP5RxYQ58tcQ_1757631502
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35C831800452;
	Thu, 11 Sep 2025 22:58:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 27A5030002C6;
	Thu, 11 Sep 2025 22:58:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
To: Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH net] rxrpc: Fix unhandled errors in rxgk_verify_packet_integrity()
From: David Howells <dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2038796.1757631483.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Sep 2025 23:58:16 +0100
Message-ID: <2038804.1757631496@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

    =

rxgk_verify_packet_integrity() may get more errors than just -EPROTO from
rxgk_verify_mic_skb().  Pretty much anything other than -ENOMEM constitute=
s
an unrecoverable error.  In the case of -ENOMEM, we can just drop the
packet and wait for a retransmission.

Similar happens with rxgk_decrypt_skb() and its callers.

Fix rxgk_decrypt_skb() or rxgk_verify_mic_skb() to return a greater variet=
y
of abort codes and fix their callers to abort the connection on any error
apart from -ENOMEM.

Also preclear the variables used to hold the abort code returned from
rxgk_decrypt_skb() or rxgk_verify_mic_skb() to eliminate uninitialised
variable warnings.

Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (=
GSSAPI)")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lists.infradead.org/pipermail/linux-afs/2025-April/009739.=
html
Closes: https://lists.infradead.org/pipermail/linux-afs/2025-April/009740.=
html
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/rxgk.c        |   18 ++++++++++--------
 net/rxrpc/rxgk_app.c    |   10 ++++++----
 net/rxrpc/rxgk_common.h |   14 ++++++++++++--
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index 1e19c605bcc8..dce5a3d8a964 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -475,7 +475,7 @@ static int rxgk_verify_packet_integrity(struct rxrpc_c=
all *call,
 	struct krb5_buffer metadata;
 	unsigned int offset =3D sp->offset, len =3D sp->len;
 	size_t data_offset =3D 0, data_len =3D len;
-	u32 ac;
+	u32 ac =3D 0;
 	int ret =3D -ENOMEM;
 =

 	_enter("");
@@ -499,9 +499,10 @@ static int rxgk_verify_packet_integrity(struct rxrpc_=
call *call,
 	ret =3D rxgk_verify_mic_skb(gk->krb5, gk->rx_Kc, &metadata,
 				  skb, &offset, &len, &ac);
 	kfree(hdr);
-	if (ret =3D=3D -EPROTO) {
-		rxrpc_abort_eproto(call, skb, ac,
-				   rxgk_abort_1_verify_mic_eproto);
+	if (ret < 0) {
+		if (ret !=3D -ENOMEM)
+			rxrpc_abort_eproto(call, skb, ac,
+					   rxgk_abort_1_verify_mic_eproto);
 	} else {
 		sp->offset =3D offset;
 		sp->len =3D len;
@@ -524,15 +525,16 @@ static int rxgk_verify_packet_encrypted(struct rxrpc=
_call *call,
 	struct rxgk_header hdr;
 	unsigned int offset =3D sp->offset, len =3D sp->len;
 	int ret;
-	u32 ac;
+	u32 ac =3D 0;
 =

 	_enter("");
 =

 	ret =3D rxgk_decrypt_skb(gk->krb5, gk->rx_enc, skb, &offset, &len, &ac);
-	if (ret =3D=3D -EPROTO)
-		rxrpc_abort_eproto(call, skb, ac, rxgk_abort_2_decrypt_eproto);
-	if (ret < 0)
+	if (ret < 0) {
+		if (ret !=3D -ENOMEM)
+			rxrpc_abort_eproto(call, skb, ac, rxgk_abort_2_decrypt_eproto);
 		goto error;
+	}
 =

 	if (len < sizeof(hdr)) {
 		ret =3D rxrpc_abort_eproto(call, skb, RXGK_PACKETSHORT,
diff --git a/net/rxrpc/rxgk_app.c b/net/rxrpc/rxgk_app.c
index b94b77a1c317..df684b5a8531 100644
--- a/net/rxrpc/rxgk_app.c
+++ b/net/rxrpc/rxgk_app.c
@@ -187,7 +187,7 @@ int rxgk_extract_token(struct rxrpc_connection *conn, =
struct sk_buff *skb,
 	struct key *server_key;
 	unsigned int ticket_offset, ticket_len;
 	u32 kvno, enctype;
-	int ret, ec;
+	int ret, ec =3D 0;
 =

 	struct {
 		__be32 kvno;
@@ -236,9 +236,11 @@ int rxgk_extract_token(struct rxrpc_connection *conn,=
 struct sk_buff *skb,
 			       &ticket_offset, &ticket_len, &ec);
 	crypto_free_aead(token_enc);
 	token_enc =3D NULL;
-	if (ret < 0)
-		return rxrpc_abort_conn(conn, skb, ec, ret,
-					rxgk_abort_resp_tok_dec);
+	if (ret < 0) {
+		if (ret !=3D -ENOMEM)
+			return rxrpc_abort_conn(conn, skb, ec, ret,
+						rxgk_abort_resp_tok_dec);
+	}
 =

 	ret =3D conn->security->default_decode_ticket(conn, skb, ticket_offset,
 						    ticket_len, _key);
diff --git a/net/rxrpc/rxgk_common.h b/net/rxrpc/rxgk_common.h
index 7370a5655985..80164d89e19c 100644
--- a/net/rxrpc/rxgk_common.h
+++ b/net/rxrpc/rxgk_common.h
@@ -88,11 +88,16 @@ int rxgk_decrypt_skb(const struct krb5_enctype *krb5,
 		*_offset +=3D offset;
 		*_len =3D len;
 		break;
+	case -EBADMSG: /* Checksum mismatch. */
 	case -EPROTO:
-	case -EBADMSG:
 		*_error_code =3D RXGK_SEALEDINCON;
 		break;
+	case -EMSGSIZE:
+		*_error_code =3D RXGK_PACKETSHORT;
+		break;
+	case -ENOPKG: /* Would prefer RXGK_BADETYPE, but not available for YFS. =
*/
 	default:
+		*_error_code =3D RXGK_INCONSISTENCY;
 		break;
 	}
 =

@@ -127,11 +132,16 @@ int rxgk_verify_mic_skb(const struct krb5_enctype *k=
rb5,
 		*_offset +=3D offset;
 		*_len =3D len;
 		break;
+	case -EBADMSG: /* Checksum mismatch */
 	case -EPROTO:
-	case -EBADMSG:
 		*_error_code =3D RXGK_SEALEDINCON;
 		break;
+	case -EMSGSIZE:
+		*_error_code =3D RXGK_PACKETSHORT;
+		break;
+	case -ENOPKG: /* Would prefer RXGK_BADETYPE, but not available for YFS. =
*/
 	default:
+		*_error_code =3D RXGK_INCONSISTENCY;
 		break;
 	}
 =


