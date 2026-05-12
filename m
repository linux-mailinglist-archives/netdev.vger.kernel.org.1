Return-Path: <netdev+bounces-287000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDm3BkHjAmpEyQEAu9opvQ
	(envelope-from <netdev+bounces-287000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:22:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A13FC51C9A6
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E64853019015
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C060F48C8D4;
	Tue, 12 May 2026 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="GdVAlA7n"
X-Original-To: netdev@vger.kernel.org
Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFD31E8342
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574142; cv=none; b=XJN88f0L2OGINtGLg2pQMv4ggR9Vr5pNlz5EFckfwGYAyZZ5nqgVpY/Ytvc/uPz/WrXWzSyi24TTjBoTIYWq2JQlp++dVM8+waE06dzDLmkyJTZkyIajbpzzTviesvY2tY9ZNdtRIsqknjLHXdMuknqdScA2CMADhapUv0y/7do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574142; c=relaxed/simple;
	bh=G6CVKquVXequLSuFySMeJgJchf3txmL2HjF2DAHPtJE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NVNo2yXZN8O/kOOLk7XX20gcepoVirhLP+ANzjFGDowh7E0kxZDwlg//zgviJHZWTmVGDSUGLZ/3Etg4iR11JJ2O3Orvs0nuE0Oze5Tt2GipUzV74mZXF4Rc8JoRyNL/+Db+WqUFKwgSON4t09nkbGtm2VHIbPPK9d/IpNJLu3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=GdVAlA7n; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=39349; t=1778574097;
	x=1779178897; i=jaltman@auristor.com; q=dns/txt; h=Content-Type:
	Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	Content-Transfer-Encoding:Message-Id:References:To; z=Received:=
	20from=20smtpclient.apple=20([146.70.171.97])=20by=20auristor.co
	m=20(208.125.0.237)=20(MDaemon=20PRO=20v26.0.2b)=20=0D=0A=09with
	=20ESMTPSA=20id=20md5001005266565.msg=3B=20Tue,=2012=20May=20202
	6=2004=3A21=3A37=20-0400|Content-Type:=20multipart/signed=3B=0D=
	0A=09boundary=3D"Apple-Mail=3D_ACC71318-2940-4497-BA79-7D203D724
	4E0"=3B=0D=0A=09protocol=3D"application/pkcs7-signature"=3B=0D=0
	A=09micalg=3Dsha-256|Mime-Version:=201.0=20(Mac=20OS=20X=20Mail=
	2016.0=20\(3826.700.81.1.8\))|Subject:=20Re=3A=20[PATCH=20net=20
	3/3]=20rxrpc=3A=20Fix=20RESPONSE=20packet=20verification=20to=0D
	=0A=20extract=20skb=20to=20a=20linear=20buffer|From:=20Jeffrey=2
	0Altman=20<jaltman@auristor.com>|In-Reply-To:=20<20260511160753.
	607296-4-dhowells@redhat.com>|Date:=20Tue,=2012=20May=202026=200
	4=3A22=3A06=20-0400|Cc:=20netdev@vger.kernel.org,=0D=0A=20Hyunwo
	o=20Kim=20<imv4bel@gmail.com>,=0D=0A=20Marc=20Dionne=20<marc.dio
	nne@auristor.com>,=0D=0A=20Jakub=20Kicinski=20<kuba@kernel.org>,
	=0D=0A=20"David=20S.=20Miller"=20<davem@davemloft.net>,=0D=0A=20
	Eric=20Dumazet=20<edumazet@google.com>,=0D=0A=20Paolo=20Abeni=20
	<pabeni@redhat.com>,=0D=0A=20Simon=20Horman=20<horms@kernel.org>
	,=0D=0A=20linux-afs@lists.infradead.org,=0D=0A=20linux-kernel@vg
	er.kernel.org,=0D=0A=20Jiayuan=20Chen=20<jiayuan.chen@linux.dev>
	,=0D=0A=20stable@kernel.org|Content-Transfer-Encoding:=20quoted-
	printable|Message-Id:=20<36B5015D-2475-48B2-83B4-763C10F37CFE@au
	ristor.com>|References:=20<20260511160753.607296-1-dhowells@redh
	at.com>=0D=0A=20<20260511160753.607296-4-dhowells@redhat.com>|To
	:=20David=20Howells=20<dhowells@redhat.com>; bh=ozpMSlM6NLEppEba
	aTDfM5ZHd0s6So89FSQ0XjzEmSE=; b=GdVAlA7nIwug0b/lHknXI1U5Bi9gcJtk
	M2tl7gPPDceCKNumFkPxUqvl1ZItsM4D/RXU+tDZqDJGc3sIohY+S9KeUzsazkGR
	C4UAetRLCBPMt28WeZ/ORTnLdMVxdd/Q/Sc6jivHI7gqQ9LWWHO5qaP7+oTHLAQG
	jkQ9N4HToR0=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Tue, 12 May 2026 04:21:37 -0400
Received: from smtpclient.apple ([146.70.171.97]) by auristor.com (208.125.0.237) (MDaemon PRO v26.0.2b) 
	with ESMTPSA id md5001005266565.msg; Tue, 12 May 2026 04:21:37 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Tue, 12 May 2026 04:21:37 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 146.70.171.97
X-MDHelo: smtpclient.apple
X-MDArrival-Date: Tue, 12 May 2026 04:21:37 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=159257c7c2=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: netdev@vger.kernel.org
Content-Type: multipart/signed;
	boundary="Apple-Mail=_ACC71318-2940-4497-BA79-7D203D7244E0";
	protocol="application/pkcs7-signature";
	micalg=sha-256
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH net 3/3] rxrpc: Fix RESPONSE packet verification to
 extract skb to a linear buffer
From: Jeffrey Altman <jaltman@auristor.com>
In-Reply-To: <20260511160753.607296-4-dhowells@redhat.com>
Date: Tue, 12 May 2026 04:22:06 -0400
Cc: netdev@vger.kernel.org,
 Hyunwoo Kim <imv4bel@gmail.com>,
 Marc Dionne <marc.dionne@auristor.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Jiayuan Chen <jiayuan.chen@linux.dev>,
 stable@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <36B5015D-2475-48B2-83B4-763C10F37CFE@auristor.com>
References: <20260511160753.607296-1-dhowells@redhat.com>
 <20260511160753.607296-4-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-MDCFSigsAdded: auristor.com
X-Rspamd-Queue-Id: A13FC51C9A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[auristor.com,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[auristor.com:s=MDaemon];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287000-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	HAS_X_AS(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[auristor.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaltman@auristor.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,auristor.com,kernel.org,davemloft.net,google.com,redhat.com,lists.infradead.org,linux.dev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linux.dev:email,auristor.com:email,auristor.com:mid,auristor.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,davemloft.net:email]
X-Rspamd-Action: no action

--Apple-Mail=_ACC71318-2940-4497-BA79-7D203D7244E0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On May 11, 2026, at 12:07=E2=80=AFPM, David Howells =
<dhowells@redhat.com> wrote:
>=20
> This improves the fix for CVE-2026-43500.
>=20
> Fix the verification of RESPONSE packets to avoid the problem of
> overwriting a RESPONSE packet sent via splice to a local address by
> extracting the contents of the UDP packet into a kmalloc'd linear =
buffer
> rather than decrypting the data in place in the sk_buff (which may =
corrupt
> the original buffer).
>=20
> Further, since the way the RESPONSE data is handled is being =
overhauled,
> add an XDR decode abstraction that hides the details of buffer =
advancement
> and length checking.  At some point it may be worth seeing if NFS's =
XDR
> stuff can be used, but that involves linking against the sunrpc module
> which is undesirable.
>=20

Might be worth adding a back-porting note that the rxgk changes can be
safely dropped if the kernel does not support rxgk.


> Fixes: 24481a7f5733 ("rxrpc: Fix conn-level packet handling to unshare =
RESPONSE packets")
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Closes: https://lore.kernel.org/r/afKV2zGR6rrelPC7@v4bel/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Jeffrey Altman <jaltman@auristor.com>
> cc: Eric Dumazet <edumazet@google.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Simon Horman <horms@kernel.org>
> cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> cc: linux-afs@lists.infradead.org
> cc: netdev@vger.kernel.org
> cc: stable@kernel.org
> ---
> net/rxrpc/ar-internal.h |  70 +++++++++++++++++--
> net/rxrpc/conn_event.c  |  35 +++++-----
> net/rxrpc/insecure.c    |   5 +-
> net/rxrpc/protocol.h    |   1 -
> net/rxrpc/rxgk.c        | 146 +++++++++++++---------------------------
> net/rxrpc/rxgk_app.c    |  91 +++++++++++--------------
> net/rxrpc/rxgk_common.h | 115 ++++---------------------------
> net/rxrpc/rxkad.c       |  89 ++++++++++--------------
> 8 files changed, 219 insertions(+), 333 deletions(-)
>=20
> diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
> index 783367eea798..610fa208157b 100644
> --- a/net/rxrpc/ar-internal.h
> +++ b/net/rxrpc/ar-internal.h
> @@ -33,6 +33,13 @@ struct rxrpc_txbuf;
> struct rxrpc_txqueue;
> struct rxgk_context;
>=20
> +typedef __be32 xdr_t;
> +
> +struct xdr_buffer {
> + xdr_t *p; /* Current decode point */
> + unsigned int len; /* Amount left in buffer */
> +};
> +
> /*
>  * Mark applied to socket buffers in skb->mark.  skb->priority is used
>  * to pass supplementary information.
> @@ -307,16 +314,16 @@ struct rxrpc_security {
>    struct sk_buff *challenge);
>=20
> /* verify a response */
> - int (*verify_response)(struct rxrpc_connection *,
> -       struct sk_buff *);
> + int (*verify_response)(struct rxrpc_connection *conn,
> +       struct sk_buff *response_skb,
> +       struct xdr_buffer *response);
>=20
> /* clear connection security */
> void (*clear)(struct rxrpc_connection *);
>=20
> /* Default ticket -> key decoder */
> int (*default_decode_ticket)(struct rxrpc_connection *conn, struct =
sk_buff *skb,
> -     unsigned int ticket_offset, unsigned int ticket_len,
> -     struct key **_key);
> +     struct xdr_buffer *ticket, struct key **_key);
> };
>=20
> /*
> @@ -1591,6 +1598,61 @@ static inline unsigned int =
rxrpc_tx_in_flight(const struct rxrpc_call *call)
> return call->tx_nr_sent - rxrpc_left_out(call) + call->tx_nr_resent;
> }
>=20
> +#define xdr_round_up(x) (round_up((x), sizeof(__be32)))
> +#define xdr_round_down(x) (round_down((x), sizeof(__be32)))
> +#define xdr_object_len(x) (4 + xdr_round_up(x))
> +
> +/*
> + * Check the amount of data remaining in an XDR buffer.
> + */
> +static inline bool xdr_check(struct xdr_buffer *buf, unsigned int =
bytes)
> +{
> + if (bytes > buf->len ||
> +    xdr_round_up(bytes) > buf->len)
> + return false;
> + return true;
> +}
> +
> +/*
> + * Grab a region in an XDR buffer and advance the buffer position, =
returning a
> + * pointer to the start of the region or NULL if there's insufficient =
data.
> + */
> +static inline void *xdr_extract_region(struct xdr_buffer *buf, =
unsigned int bytes)
> +{
> + xdr_t *p =3D buf->p;
> +
> + if (!xdr_check(buf, bytes))
> + return NULL;
> +
> + bytes =3D xdr_round_up(bytes);
> + buf->p   +=3D bytes / sizeof(*buf->p);
> + buf->len -=3D bytes;
> + return p;
> +}
> +
> +/*
> + * Decode an XDR word.
> + */
> +static inline u32 xdr_dec(xdr_t x)
> +{
> + return ntohl(x);
> +}
> +
> +/*
> + * Grab a blob with size from an XDR buffer and advance the buffer =
position.
> + */
> +static inline bool xdr_extract_blob(struct xdr_buffer *buf, struct =
xdr_buffer *blob)
> +{
> + xdr_t *xsize;
> +
> + xsize =3D xdr_extract_region(buf, sizeof(*xsize));
> + if (!xsize)
> + return false;
> + blob->len =3D xdr_dec(*xsize);
> + blob->p   =3D xdr_extract_region(buf, blob->len);
> + return blob->p !=3D NULL;
> +}
> +
> /*
>  * debug tracing
>  */
> diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
> index 442414d90ba1..26cab3d2075e 100644
> --- a/net/rxrpc/conn_event.c
> +++ b/net/rxrpc/conn_event.c
> @@ -243,28 +243,25 @@ static void rxrpc_call_is_secure(struct =
rxrpc_call *call)
> static int rxrpc_verify_response(struct rxrpc_connection *conn,
> struct sk_buff *skb)
> {
> + struct xdr_buffer response =3D {
> + .len =3D skb->len - sizeof(struct rxrpc_wire_header),
> + };
> + void *buffer;
> int ret;
>=20
> - if (skb_cloned(skb) || skb_has_frag_list(skb) ||
> -    skb_has_shared_frag(skb)) {
> - /* Copy the packet if shared so that we can do in-place
> - * decryption.
> - */
> - struct sk_buff *nskb =3D skb_copy(skb, GFP_NOFS);
> -
> - if (nskb) {
> - rxrpc_new_skb(nskb, rxrpc_skb_new_unshared);
> - ret =3D conn->security->verify_response(conn, nskb);
> - rxrpc_free_skb(nskb, rxrpc_skb_put_response_copy);
> - } else {
> - /* OOM - Drop the packet. */
> - rxrpc_see_skb(skb, rxrpc_skb_see_unshare_nomem);
> - ret =3D -ENOMEM;
> - }
> - } else {
> - ret =3D conn->security->verify_response(conn, skb);
> - }
> + buffer =3D kmalloc(response.len, GFP_NOFS);
> + if (!buffer)
> + return ret;
> +
> + ret =3D skb_copy_bits(skb, sizeof(struct rxrpc_wire_header), buffer, =
response.len);
> + if (ret < 0)
> + goto out;
> +
> + response.p =3D buffer;
> + ret =3D conn->security->verify_response(conn, skb, &response);
>=20
> +out:
> + kfree(buffer);
> return ret;
> }
>=20
> diff --git a/net/rxrpc/insecure.c b/net/rxrpc/insecure.c
> index 7a26c6097d03..dd1827f683bc 100644
> --- a/net/rxrpc/insecure.c
> +++ b/net/rxrpc/insecure.c
> @@ -54,9 +54,10 @@ static int none_sendmsg_respond_to_challenge(struct =
sk_buff *challenge,
> }
>=20
> static int none_verify_response(struct rxrpc_connection *conn,
> - struct sk_buff *skb)
> + struct sk_buff *response_skb,
> + struct xdr_buffer *response)
> {
> - return rxrpc_abort_conn(conn, skb, RX_PROTOCOL_ERROR, -EPROTO,
> + return rxrpc_abort_conn(conn, response_skb, RX_PROTOCOL_ERROR, =
-EPROTO,
> rxrpc_eproto_rxnull_response);
> }
>=20
> diff --git a/net/rxrpc/protocol.h b/net/rxrpc/protocol.h
> index f8bfec12bc7e..6e02a84fd370 100644
> --- a/net/rxrpc/protocol.h
> +++ b/net/rxrpc/protocol.h
> @@ -198,7 +198,6 @@ struct rxgk_header {
>  */
> struct rxgk_response {
> __be64 start_time;
> - __be32 token_len;
> } __packed;
>=20
> #endif /* _LINUX_RXRPC_PACKET_H */
> diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
> index 88e651dd0e90..fd73b1ff3b97 100644
> --- a/net/rxrpc/rxgk.c
> +++ b/net/rxrpc/rxgk.c
> @@ -524,43 +524,42 @@ static int rxgk_verify_packet_encrypted(struct =
rxrpc_call *call,
> {
> struct rxrpc_skb_priv *sp =3D rxrpc_skb(skb);
> struct rxgk_header *hdr;
> - unsigned int offset =3D 0, len =3D call->rx_dec_len;
> - void *data =3D call->rx_dec_buffer;
> + struct xdr_buffer xdr =3D {
> + .p =3D call->rx_dec_buffer,
> + .len =3D call->rx_dec_len,
> + };
> int ret;
> u32 ac =3D 0;
>=20
> _enter("");
>=20
> - ret =3D rxgk_decrypt(gk->krb5, gk->rx_enc, data, &offset, &len, =
&ac);
> + ret =3D rxgk_decrypt(gk->krb5, gk->rx_enc, &xdr, &ac);
> if (ret < 0) {
> if (ret !=3D -ENOMEM)
> rxrpc_abort_eproto(call, skb, ac, rxgk_abort_2_decrypt_eproto);
> goto error;
> }
>=20
> - if (len < sizeof(*hdr)) {
> + /* Extract the header from the skb */
> + hdr =3D xdr_extract_region(&xdr, sizeof(*hdr));
> + if (!hdr) {
> ret =3D rxrpc_abort_eproto(call, skb, RXGK_PACKETSHORT,
> rxgk_abort_2_short_header);
> goto error;
> }
>=20
> - /* Extract the header from the skb */
> - hdr =3D data + offset;
> - offset +=3D sizeof(*hdr);
> - len -=3D sizeof(*hdr);
> -
> if (ntohl(hdr->epoch) !=3D call->conn->proto.epoch ||
>    ntohl(hdr->cid) !=3D call->cid ||
>    ntohl(hdr->call_number) !=3D call->call_id ||
>    ntohl(hdr->seq) !=3D sp->hdr.seq ||
>    ntohl(hdr->sec_index) !=3D call->security_ix ||
> -    ntohl(hdr->data_len) > len) {
> +    ntohl(hdr->data_len) > xdr.len) {
> ret =3D rxrpc_abort_eproto(call, skb, RXGK_SEALEDINCON,
> rxgk_abort_2_short_data);
> goto error;
> }
>=20
> - call->rx_dec_offset =3D offset;
> + call->rx_dec_offset =3D (void *)xdr.p - call->rx_dec_buffer;
> call->rx_dec_len =3D ntohl(hdr->data_len);
> ret =3D 0;
> error:
> @@ -1073,37 +1072,37 @@ static int =
rxgk_sendmsg_respond_to_challenge(struct sk_buff *challenge,
>  * unsigned int call_numbers<>;
>  * };
>  */
> -static int rxgk_do_verify_authenticator(struct rxrpc_connection =
*conn,
> - const struct krb5_enctype *krb5,
> - struct sk_buff *skb,
> - __be32 *p, __be32 *end)
> +static int rxgk_verify_authenticator(struct rxrpc_connection *conn,
> +     const struct krb5_enctype *krb5,
> +     struct sk_buff *skb,
> +     struct xdr_buffer *auth)
> {
> - u32 app_len, call_count, level, epoch, cid, i;
> + struct xdr_buffer appdata;
> + xdr_t *nonce, *x;
> + u32 call_count, level, epoch, cid, i;
>=20
> _enter("");
>=20
> - if ((end - p) * sizeof(__be32) < 24)
> + nonce =3D xdr_extract_region(auth, 20);
> + if (!nonce)
> return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
> rxgk_abort_resp_short_auth);
> - if (memcmp(p, conn->rxgk.nonce, 20) !=3D 0)
> + if (memcmp(nonce, conn->rxgk.nonce, 20) !=3D 0)
> return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
> rxgk_abort_resp_bad_nonce);
> - p +=3D 20 / sizeof(__be32);
>=20
> - app_len =3D ntohl(*p++);
> - if (app_len > (end - p) * sizeof(__be32))
> + if (!xdr_extract_blob(auth, &appdata))
> return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
> rxgk_abort_resp_short_applen);
>=20
> - p +=3D xdr_round_up(app_len) / sizeof(__be32);
> - if (end - p < 4)
> + x =3D xdr_extract_region(auth, 4 * sizeof(xdr_t));
> + if (!x)
> return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
> rxgk_abort_resp_short_auth);
> -
> - level =3D ntohl(*p++);
> - epoch =3D ntohl(*p++);
> - cid =3D ntohl(*p++);
> - call_count =3D ntohl(*p++);
> + level   =3D xdr_dec(x[0]);
> + epoch   =3D xdr_dec(x[1]);
> + cid   =3D xdr_dec(x[2]);
> + call_count =3D xdr_dec(x[3]);
>=20
> if (level !=3D conn->security_level ||
>    epoch !=3D conn->proto.epoch ||
> @@ -1112,12 +1111,13 @@ static int rxgk_do_verify_authenticator(struct =
rxrpc_connection *conn,
> return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
> rxgk_abort_resp_bad_param);
>=20
> - if (end - p < call_count)
> + x =3D xdr_extract_region(auth, call_count * sizeof(xdr_t));
> + if (!x)
> return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
> rxgk_abort_resp_short_call_list);
>=20
> for (i =3D 0; i < call_count; i++) {
> - u32 call_id =3D ntohl(*p++);
> + u32 call_id =3D xdr_dec(x[i]);
>=20
> if (call_id > INT_MAX)
> return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
> @@ -1140,37 +1140,6 @@ static int rxgk_do_verify_authenticator(struct =
rxrpc_connection *conn,
> return 0;
> }
>=20
> -/*
> - * Extract the authenticator and verify it.
> - */
> -static int rxgk_verify_authenticator(struct rxrpc_connection *conn,
> -     const struct krb5_enctype *krb5,
> -     struct sk_buff *skb,
> -     unsigned int auth_offset, unsigned int auth_len)
> -{
> - void *auth;
> - __be32 *p;
> - int ret;
> -
> - auth =3D kmalloc(auth_len, GFP_NOFS);
> - if (!auth)
> - return -ENOMEM;
> -
> - ret =3D skb_copy_bits(skb, auth_offset, auth, auth_len);
> - if (ret < 0) {
> - ret =3D rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
> -       rxgk_abort_resp_short_auth);
> - goto error;
> - }
> -
> - p =3D auth;
> - ret =3D rxgk_do_verify_authenticator(conn, krb5, skb, p,
> -   p + auth_len / sizeof(*p));
> -error:
> - kfree(auth);
> - return ret;
> -}
> -
> /*
>  * Verify a response.
>  *
> @@ -1181,55 +1150,34 @@ static int rxgk_verify_authenticator(struct =
rxrpc_connection *conn,
>  * };
>  */
> static int rxgk_verify_response(struct rxrpc_connection *conn,
> - struct sk_buff *skb)
> + struct sk_buff *skb,
> + struct xdr_buffer *response)
> {
> const struct krb5_enctype *krb5;
> struct rxrpc_key_token *token;
> struct rxrpc_skb_priv *sp =3D rxrpc_skb(skb);
> - struct rxgk_response rhdr;
> + struct rxgk_response *rhdr;
> struct rxgk_context *gk;
> + struct xdr_buffer resp_token, auth;
> struct key *key =3D NULL;
> - unsigned int offset =3D sizeof(struct rxrpc_wire_header);
> - unsigned int len =3D skb->len - sizeof(struct rxrpc_wire_header);
> - unsigned int token_offset, token_len;
> - unsigned int auth_offset, auth_len;
> - __be32 xauth_len;
> int ret, ec;
>=20
> _enter("{%d}", conn->debug_id);
>=20
> /* Parse the RXGK_Response object */
> - if (sizeof(rhdr) + sizeof(__be32) > len)
> + rhdr =3D xdr_extract_region(response, sizeof(*rhdr));
> + if (!rhdr)
> goto short_packet;
> -
> - if (skb_copy_bits(skb, offset, &rhdr, sizeof(rhdr)) < 0)
> + if (!xdr_extract_blob(response, &resp_token))
> goto short_packet;
> - offset +=3D sizeof(rhdr);
> - len -=3D sizeof(rhdr);
> -
> - token_offset =3D offset;
> - token_len =3D ntohl(rhdr.token_len);
> - if (token_len > len ||
> -    xdr_round_up(token_len) + sizeof(__be32) > len)
> + if (!xdr_extract_blob(response, &auth))
> goto short_packet;
>=20
> - trace_rxrpc_rx_response(conn, sp->hdr.serial, 0, sp->hdr.cksum, =
token_len);
> + trace_rxrpc_rx_response(conn, sp->hdr.serial, 0, sp->hdr.cksum, =
resp_token.len);
>=20
> - offset +=3D xdr_round_up(token_len);
> - len -=3D xdr_round_up(token_len);
> -
> - if (skb_copy_bits(skb, offset, &xauth_len, sizeof(xauth_len)) < 0)
> - goto short_packet;
> - offset +=3D sizeof(xauth_len);
> - len -=3D sizeof(xauth_len);
> -
> - auth_offset =3D offset;
> - auth_len =3D ntohl(xauth_len);
> - if (auth_len > len)
> - goto short_packet;
> - if (auth_len & 3)
> + if (auth.len & 3)
> goto inconsistent;
> - if (auth_len < 20 + 9 * 4)
> + if (auth.len < 20 + 9 * 4)
> goto auth_too_short;
>=20
> /* We need to extract and decrypt the token and instantiate a session
> @@ -1238,7 +1186,7 @@ static int rxgk_verify_response(struct =
rxrpc_connection *conn,
> * to the app to deal with - which might mean a round trip to
> * userspace.
> */
> - ret =3D rxgk_extract_token(conn, skb, token_offset, token_len, =
&key);
> + ret =3D rxgk_extract_token(conn, skb, &resp_token, &key);
> if (ret < 0)
> goto out;
>=20
> @@ -1252,7 +1200,7 @@ static int rxgk_verify_response(struct =
rxrpc_connection *conn,
> */
> token =3D key->payload.data[0];
> conn->security_level =3D token->rxgk->level;
> - conn->rxgk.start_time =3D __be64_to_cpu(rhdr.start_time);
> + conn->rxgk.start_time =3D __be64_to_cpu(rhdr->start_time);
>=20
> gk =3D rxgk_generate_transport_key(conn, token->rxgk, sp->hdr.cksum, =
GFP_NOFS);
> if (IS_ERR(gk)) {
> @@ -1262,18 +1210,18 @@ static int rxgk_verify_response(struct =
rxrpc_connection *conn,
>=20
> krb5 =3D gk->krb5;
>=20
> - trace_rxrpc_rx_response(conn, sp->hdr.serial, krb5->etype, =
sp->hdr.cksum, token_len);
> + trace_rxrpc_rx_response(conn, sp->hdr.serial, krb5->etype, =
sp->hdr.cksum,
> + resp_token.len);
>=20
> /* Decrypt, parse and verify the authenticator. */
> - ret =3D rxgk_decrypt_skb(krb5, gk->resp_enc, skb,
> -       &auth_offset, &auth_len, &ec);
> + ret =3D rxgk_decrypt(krb5, gk->resp_enc, &auth, &ec);
> if (ret < 0) {
> rxrpc_abort_conn(conn, skb, RXGK_SEALEDINCON, ret,
> rxgk_abort_resp_auth_dec);
> goto out_gk;
> }
>=20
> - ret =3D rxgk_verify_authenticator(conn, krb5, skb, auth_offset, =
auth_len);
> + ret =3D rxgk_verify_authenticator(conn, krb5, skb, &auth);
> if (ret < 0)
> goto out_gk;
>=20
> diff --git a/net/rxrpc/rxgk_app.c b/net/rxrpc/rxgk_app.c
> index 0ef2a29eb695..5ced22f17c5b 100644
> --- a/net/rxrpc/rxgk_app.c
> +++ b/net/rxrpc/rxgk_app.c
> @@ -40,40 +40,43 @@
>  * };
>  */
> int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct =
sk_buff *skb,
> -   unsigned int ticket_offset, unsigned int ticket_len,
> -   struct key **_key)
> +   struct xdr_buffer *xticket, struct key **_key)
> {
> struct rxrpc_key_token *token;
> const struct cred *cred =3D current_cred(); // TODO - use socket creds
> + struct xdr_buffer xdr =3D *xticket, K0;
> struct key *key;
> size_t pre_ticket_len, payload_len;
> - unsigned int klen, enctype;
> + unsigned int enctype;
> void *payload, *ticket;
> - __be32 *t, *p, *q, tmp[2];
> + __be32 *t, *p, *q;
> + xdr_t *x;
> int ret;
>=20
> _enter("");
>=20
> - if (ticket_len < 10 * sizeof(__be32))
> + /* Extract K0 */
> + x =3D xdr_extract_region(&xdr, sizeof(xdr_t) * 1);
> + if (!x)
> return rxrpc_abort_conn(conn, skb, RXGK_INCONSISTENCY, -EPROTO,
> rxgk_abort_resp_short_yfs_tkt);
>=20
> - /* Get the session key length */
> - ret =3D skb_copy_bits(skb, ticket_offset, tmp, sizeof(tmp));
> - if (ret < 0)
> - return rxrpc_abort_conn(conn, skb, RXGK_INCONSISTENCY, -EPROTO,
> - rxgk_abort_resp_short_yfs_klen);
> - enctype =3D ntohl(tmp[0]);
> - klen =3D ntohl(tmp[1]);
> + enctype =3D xdr_dec(*x);
>=20
> - if (klen > ticket_len - 10 * sizeof(__be32))
> + if (!xdr_extract_blob(&xdr, &K0))
> return rxrpc_abort_conn(conn, skb, RXGK_INCONSISTENCY, -EPROTO,
> rxgk_abort_resp_short_yfs_key);
>=20
> + /* Extract level to expirationtime. */
> + t =3D xdr_extract_region(&xdr, sizeof(xdr_t) * 7);
> + if (!t)
> + return rxrpc_abort_conn(conn, skb, RXGK_INCONSISTENCY, -EPROTO,
> + rxgk_abort_resp_short_yfs_tkt);
> +
> pre_ticket_len =3D ((5 + 14) * sizeof(__be32) +
> -  xdr_round_up(klen) +
> +  xdr_round_up(K0.len) +
>  sizeof(__be32));
> - payload_len =3D pre_ticket_len + xdr_round_up(ticket_len);
> + payload_len =3D pre_ticket_len + xdr_round_up(xticket->len);
>=20
> payload =3D kzalloc(payload_len, GFP_NOFS);
> if (!payload)
> @@ -84,12 +87,7 @@ int rxgk_yfs_decode_ticket(struct rxrpc_connection =
*conn, struct sk_buff *skb,
> * it.
> */
> ticket =3D payload + pre_ticket_len;
> - ret =3D skb_copy_bits(skb, ticket_offset, ticket, ticket_len);
> - if (ret < 0) {
> - ret =3D rxrpc_abort_conn(conn, skb, RXGK_INCONSISTENCY, -EPROTO,
> -       rxgk_abort_resp_short_yfs_tkt);
> - goto error;
> - }
> + memcpy(ticket, xticket->p, xticket->len);
>=20
> /* Fill out the form header. */
> p =3D payload;
> @@ -97,13 +95,12 @@ int rxgk_yfs_decode_ticket(struct rxrpc_connection =
*conn, struct sk_buff *skb,
> p[1] =3D htonl(1); /* len(cellname) */
> p[2] =3D htonl(0x20000000); /* Cellname " " */
> p[3] =3D htonl(1); /* #tokens */
> - p[4] =3D htonl(15 * sizeof(__be32) + xdr_round_up(klen) +
> -     xdr_round_up(ticket_len)); /* Token len */
> + p[4] =3D htonl(15 * sizeof(__be32) + xdr_round_up(K0.len) +
> +     xdr_round_up(xticket->len)); /* Token len */
>=20
> /* Now fill in the body.  Most of this we can just scrape directly =
from
> * the ticket.
> */
> - t =3D ticket + sizeof(__be32) * 2 + xdr_round_up(klen);
> q =3D payload + 5 * sizeof(__be32);
> q[0]  =3D htonl(RXRPC_SECURITY_YFS_RXGK);
> q[1]  =3D t[1]; /* begintime - msw */
> @@ -118,21 +115,21 @@ int rxgk_yfs_decode_ticket(struct =
rxrpc_connection *conn, struct sk_buff *skb,
> q[10] =3D t[4]; /* - lsw */
> q[11] =3D 0; /* enctype - msw */
> q[12] =3D htonl(enctype); /* - lsw */
> - q[13] =3D htonl(klen); /* Key length */
> + q[13] =3D htonl(K0.len); /* Key length */
>=20
> q +=3D 14;
>=20
> - memcpy(q, ticket + sizeof(__be32) * 2, klen);
> - q +=3D xdr_round_up(klen) / 4;
> - q[0] =3D htonl(ticket_len);
> + memcpy(q, K0.p, K0.len);
> + q +=3D xdr_round_up(K0.len) / 4;
> + q[0] =3D htonl(xticket->len);
> q++;
> if (WARN_ON((unsigned long)q !=3D (unsigned long)ticket)) {
> ret =3D -EIO;
> goto error;
> }
>=20
> - /* Ticket read in with skb_copy_bits above */
> - q +=3D xdr_round_up(ticket_len) / 4;
> + /* Ticket appended above. */
> + q +=3D xdr_round_up(xticket->len) / 4;
> if (WARN_ON((unsigned long)q - (unsigned long)payload !=3D =
payload_len)) {
> ret =3D -EIO;
> goto error;
> @@ -182,44 +179,34 @@ int rxgk_yfs_decode_ticket(struct =
rxrpc_connection *conn, struct sk_buff *skb,
>  * [tools.ietf.org/html/draft-wilkinson-afs3-rxgk-afs-08 sec 6.1]
>  */
> int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff =
*skb,
> -       unsigned int token_offset, unsigned int token_len,
> -       struct key **_key)
> +       struct xdr_buffer *token, struct key **_key)
> {
> const struct krb5_enctype *krb5;
> const struct krb5_buffer *server_secret;
> struct crypto_aead *token_enc =3D NULL;
> + struct xdr_buffer ticket;
> struct key *server_key;
> - unsigned int ticket_offset, ticket_len;
> u32 kvno, enctype;
> int ret, ec =3D 0;
>=20
> struct {
> __be32 kvno;
> __be32 enctype;
> - __be32 token_len;
> - } container;
> + } *container;
>=20
> - if (token_len < sizeof(container))
> + container =3D xdr_extract_region(token, sizeof(container));
> + if (!container)
> goto short_packet;
>=20
> /* Decode the RXGK_TokenContainer object.  This tells us which server
> * key we should be using.  We can then fetch the key, get the secret
> * and set up the crypto to extract the token.
> */
> - if (skb_copy_bits(skb, token_offset, &container, sizeof(container)) =
< 0)
> - goto short_packet;
> -
> - kvno =3D ntohl(container.kvno);
> - enctype =3D ntohl(container.enctype);
> - ticket_len =3D ntohl(container.token_len);
> - ticket_offset =3D token_offset + sizeof(container);
> -
> - if (ticket_len > xdr_round_down(token_len - sizeof(container)))
> - goto short_packet;
> + kvno =3D ntohl(container->kvno);
> + enctype =3D ntohl(container->enctype);
>=20
> _debug("KVNO %u", kvno);
> _debug("ENC  %u", enctype);
> - _debug("TLEN %u", ticket_len);
>=20
> server_key =3D rxrpc_look_up_server_security(conn, skb, kvno, =
enctype);
> if (IS_ERR(server_key))
> @@ -237,8 +224,11 @@ int rxgk_extract_token(struct rxrpc_connection =
*conn, struct sk_buff *skb,
> * gain access to K0, from which we can derive the transport key and
> * thence decode the authenticator.
> */
> - ret =3D rxgk_decrypt_skb(krb5, token_enc, skb,
> -       &ticket_offset, &ticket_len, &ec);
> + if (!xdr_extract_blob(token, &ticket))
> + goto short_packet;
> + _debug("TLEN %u", ticket.len);
> +
> + ret =3D rxgk_decrypt(krb5, token_enc, &ticket, &ec);
> crypto_free_aead(token_enc);
> token_enc =3D NULL;
> if (ret < 0) {
> @@ -248,8 +238,7 @@ int rxgk_extract_token(struct rxrpc_connection =
*conn, struct sk_buff *skb,
> return ret;
> }
>=20
> - ret =3D conn->security->default_decode_ticket(conn, skb, =
ticket_offset,
> -    ticket_len, _key);
> + ret =3D conn->security->default_decode_ticket(conn, skb, &ticket, =
_key);
> if (ret < 0)
> goto cant_get_token;
>=20
> diff --git a/net/rxrpc/rxgk_common.h b/net/rxrpc/rxgk_common.h
> index dc8b0f106104..f0b724c44036 100644
> --- a/net/rxrpc/rxgk_common.h
> +++ b/net/rxrpc/rxgk_common.h
> @@ -33,19 +33,13 @@ struct rxgk_context {
> struct crypto_aead *resp_enc; /* Response packet enc key */
> };
>=20
> -#define xdr_round_up(x) (round_up((x), sizeof(__be32)))
> -#define xdr_round_down(x) (round_down((x), sizeof(__be32)))
> -#define xdr_object_len(x) (4 + xdr_round_up(x))
> -
> /*
>  * rxgk_app.c
>  */
> int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct =
sk_buff *skb,
> -   unsigned int ticket_offset, unsigned int ticket_len,
> -   struct key **_key);
> +   struct xdr_buffer *xticket, struct key **_key);
> int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff =
*skb,
> -       unsigned int token_offset, unsigned int token_len,
> -       struct key **_key);
> +       struct xdr_buffer *token, struct key **_key);
>=20
> /*
>  * rxgk_kdf.c
> @@ -61,50 +55,6 @@ int rxgk_set_up_token_cipher(const struct =
krb5_buffer *server_key,
>     const struct krb5_enctype **_krb5,
>     gfp_t gfp);
>=20
> -/*
> - * Apply decryption and checksumming functions to part of an skbuff.  =
The
> - * offset and length are updated to reflect the actual content of the =
encrypted
> - * region.
> - */
> -static inline
> -int rxgk_decrypt_skb(const struct krb5_enctype *krb5,
> -     struct crypto_aead *aead,
> -     struct sk_buff *skb,
> -     unsigned int *_offset, unsigned int *_len,
> -     int *_error_code)
> -{
> - struct scatterlist sg[16];
> - size_t offset =3D 0, len =3D *_len;
> - int nr_sg, ret;
> -
> - sg_init_table(sg, ARRAY_SIZE(sg));
> - nr_sg =3D skb_to_sgvec(skb, sg, *_offset, len);
> - if (unlikely(nr_sg < 0))
> - return nr_sg;
> -
> - ret =3D crypto_krb5_decrypt(krb5, aead, sg, nr_sg,
> -  &offset, &len);
> - switch (ret) {
> - case 0:
> - *_offset +=3D offset;
> - *_len =3D len;
> - break;
> - case -EBADMSG: /* Checksum mismatch. */
> - case -EPROTO:
> - *_error_code =3D RXGK_SEALEDINCON;
> - break;
> - case -EMSGSIZE:
> - *_error_code =3D RXGK_PACKETSHORT;
> - break;
> - case -ENOPKG: /* Would prefer RXGK_BADETYPE, but not available for =
YFS. */
> - default:
> - *_error_code =3D RXGK_INCONSISTENCY;
> - break;
> - }
> -
> - return ret;
> -}
> -
> /*
>  * Apply decryption and checksumming functions a flat data buffer.  =
The offset
>  * and length are updated to reflect the actual content of the =
encrypted
> @@ -112,21 +62,24 @@ int rxgk_decrypt_skb(const struct krb5_enctype =
*krb5,
>  */
> static inline int rxgk_decrypt(const struct krb5_enctype *krb5,
>       struct crypto_aead *aead,
> -       void *data,
> -       unsigned int *_offset, unsigned int *_len,
> +       struct xdr_buffer *buf,
>       int *_error_code)
> {
> struct scatterlist sg[1];
> - size_t offset =3D 0, len =3D *_len;
> + size_t offset =3D 0, len =3D buf->len;
> int ret;
>=20
> - sg_init_one(sg, data, len);
> -
> + sg_init_one(sg, buf->p, len);
> ret =3D crypto_krb5_decrypt(krb5, aead, sg, 1, &offset, &len);
> switch (ret) {
> case 0:
> - *_offset +=3D offset;
> - *_len =3D len;
> + if (offset & 3) {
> + *_error_code =3D RXGK_INCONSISTENCY;
> + ret =3D -EPROTO;
> + break;
> + }
> + buf->p   =3D (void *)buf->p + offset;
> + buf->len =3D len;
> break;
> case -EBADMSG: /* Checksum mismatch. */
> case -EPROTO:
> @@ -144,50 +97,6 @@ static inline int rxgk_decrypt(const struct =
krb5_enctype *krb5,
> return ret;
> }
>=20
> -/*
> - * Check the MIC on a region of an skbuff.  The offset and length are =
updated
> - * to reflect the actual content of the secure region.
> - */
> -static inline
> -int rxgk_verify_mic_skb(const struct krb5_enctype *krb5,
> - struct crypto_shash *shash,
> - const struct krb5_buffer *metadata,
> - struct sk_buff *skb,
> - unsigned int *_offset, unsigned int *_len,
> - u32 *_error_code)
> -{
> - struct scatterlist sg[16];
> - size_t offset =3D 0, len =3D *_len;
> - int nr_sg, ret;
> -
> - sg_init_table(sg, ARRAY_SIZE(sg));
> - nr_sg =3D skb_to_sgvec(skb, sg, *_offset, len);
> - if (unlikely(nr_sg < 0))
> - return nr_sg;
> -
> - ret =3D crypto_krb5_verify_mic(krb5, shash, metadata, sg, nr_sg,
> -     &offset, &len);
> - switch (ret) {
> - case 0:
> - *_offset +=3D offset;
> - *_len =3D len;
> - break;
> - case -EBADMSG: /* Checksum mismatch */
> - case -EPROTO:
> - *_error_code =3D RXGK_SEALEDINCON;
> - break;
> - case -EMSGSIZE:
> - *_error_code =3D RXGK_PACKETSHORT;
> - break;
> - case -ENOPKG: /* Would prefer RXGK_BADETYPE, but not available for =
YFS. */
> - default:
> - *_error_code =3D RXGK_INCONSISTENCY;
> - break;
> - }
> -
> - return ret;
> -}
> -
> /*
>  * Check the MIC on a flat buffer.  The offset and length are updated =
to
>  * reflect the actual content of the secure region.
> diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
> index 075936337836..e0f3db451b05 100644
> --- a/net/rxrpc/rxkad.c
> +++ b/net/rxrpc/rxkad.c
> @@ -963,7 +963,6 @@ static int rxkad_decrypt_ticket(struct =
rxrpc_connection *conn,
> *_expiry =3D 0;
>=20
> ASSERT(server_key->payload.data[0] !=3D NULL);
> - ASSERTCMP((unsigned long) ticket & 7UL, =3D=3D, 0);
>=20
> memcpy(&iv, &server_key->payload.data[2], sizeof(iv));
>=20
> @@ -1112,20 +1111,49 @@ static int rxkad_decrypt_response(struct =
rxrpc_connection *conn,
>  * verify a response
>  */
> static int rxkad_verify_response(struct rxrpc_connection *conn,
> - struct sk_buff *skb)
> + struct sk_buff *skb,
> + struct xdr_buffer *response_xdr)
> {
> struct rxkad_response *response;
> struct rxrpc_skb_priv *sp =3D rxrpc_skb(skb);
> struct rxrpc_crypt session_key;
> struct key *server_key;
> time64_t expiry;
> - void *ticket =3D NULL;
> + void *ticket;
> u32 version, kvno, ticket_len, level;
> __be32 csum;
> int ret, i;
>=20
> _enter("{%d}", conn->debug_id);
>=20
> + response =3D xdr_extract_region(response_xdr, sizeof(*response));
> + if (!response)
> + return rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
> + rxkad_abort_resp_short);
> +
> + version =3D ntohl(response->version);
> + ticket_len =3D ntohl(response->ticket_len);
> + kvno =3D ntohl(response->kvno);
> +
> + trace_rxrpc_rx_response(conn, sp->hdr.serial, version, kvno, =
ticket_len);
> +
> + if (version !=3D RXKAD_VERSION)
> + return rxrpc_abort_conn(conn, skb, RXKADINCONSISTENCY, -EPROTO,
> +       rxkad_abort_resp_version);
> +
> + if (kvno >=3D RXKAD_TKT_TYPE_KERBEROS_V5)
> + return rxrpc_abort_conn(conn, skb, RXKADUNKNOWNKEY, -EPROTO,
> + rxkad_abort_resp_unknown_tkt);
> +
> + ticket =3D xdr_extract_region(response_xdr, ticket_len);
> + if (!ticket)
> + return rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
> + rxkad_abort_resp_short_tkt);
> +
> + if (ticket_len < 4 || ticket_len > MAXKRB5TICKETLEN)
> + return rxrpc_abort_conn(conn, skb, RXKADTICKETLEN, -EPROTO,
> + rxkad_abort_resp_tkt_len);
> +
> server_key =3D rxrpc_look_up_server_security(conn, skb, 0, 0);
> if (IS_ERR(server_key)) {
> ret =3D PTR_ERR(server_key);
> @@ -1142,55 +1170,10 @@ static int rxkad_verify_response(struct =
rxrpc_connection *conn,
> }
> }
>=20
> - ret =3D -ENOMEM;
> - response =3D kzalloc_obj(struct rxkad_response, GFP_NOFS);
> - if (!response)
> - goto error;
> -
> - if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header),
> -  response, sizeof(*response)) < 0) {
> - ret =3D rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
> -       rxkad_abort_resp_short);
> - goto error;
> - }
> -
> - version =3D ntohl(response->version);
> - ticket_len =3D ntohl(response->ticket_len);
> - kvno =3D ntohl(response->kvno);
> -
> - trace_rxrpc_rx_response(conn, sp->hdr.serial, version, kvno, =
ticket_len);
> -
> - if (version !=3D RXKAD_VERSION) {
> - ret =3D rxrpc_abort_conn(conn, skb, RXKADINCONSISTENCY, -EPROTO,
> -       rxkad_abort_resp_version);
> - goto error;
> - }
> -
> - if (ticket_len < 4 || ticket_len > MAXKRB5TICKETLEN) {
> - ret =3D rxrpc_abort_conn(conn, skb, RXKADTICKETLEN, -EPROTO,
> -       rxkad_abort_resp_tkt_len);
> - goto error;
> - }
> -
> - if (kvno >=3D RXKAD_TKT_TYPE_KERBEROS_V5) {
> - ret =3D rxrpc_abort_conn(conn, skb, RXKADUNKNOWNKEY, -EPROTO,
> -       rxkad_abort_resp_unknown_tkt);
> - goto error;
> - }
> -
> - /* extract the kerberos ticket and decrypt and decode it */
> - ret =3D -ENOMEM;
> - ticket =3D kmalloc(ticket_len, GFP_NOFS);
> - if (!ticket)
> - goto error;
> -
> - if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header) + =
sizeof(*response),
> -  ticket, ticket_len) < 0) {
> - ret =3D rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
> -       rxkad_abort_resp_short_tkt);
> - goto error;
> - }
> -
> + /* Extract the kerberos ticket and decrypt and decode it.  We copy =
it
> + * before decryption which ensures it's correctly aligned for the
> + * decryption.
> + */
> ret =3D rxkad_decrypt_ticket(conn, server_key, skb, ticket, =
ticket_len,
>   &session_key, &expiry);
> if (ret < 0)
> @@ -1265,8 +1248,6 @@ static int rxkad_verify_response(struct =
rxrpc_connection *conn,
> ret =3D rxrpc_get_server_data_key(conn, &session_key, expiry, kvno);
>=20
> error:
> - kfree(ticket);
> - kfree(response);
> key_put(server_key);
> _leave(" =3D %d", ret);
> return ret;
>=20

It would be easier to review this change if the use of a temporary =
buffer was=20
separated from the XDR abstraction changes.  Would it be possible to do =
so?

Thank you.

Jeffrey Altman=

--Apple-Mail=_ACC71318-2940-4497-BA79-7D203D7244E0
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDTAw
ggY0MIIEHKADAgECAhBAAZimBAJ19t4m6OTgn3OxMA0GCSqGSIb3DQEBCwUAMDoxCzAJBgNVBAYT
AlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTE0MB4XDTI1MDgx
NDAwMzg1N1oXDTI3MTEwMTAwMzc1N1owgcwxKDAmBgNVBAUTH0EwMTQxMEMwMDAwMDE5OEE2MDQw
MjY3MDAxMEYyNjIxGTAXBgNVBGETEE5UUlVTK05ZLTM1ODIyMzcxFTATBgNVBAoTDEF1cmlTdG9y
IEluYzEZMBcGA1UEAxMQSmVmZnJleSBFIEFsdG1hbjEPMA0GA1UEBBMGQWx0bWFuMRAwDgYDVQQq
EwdKZWZmcmV5MSMwIQYJKoZIhvcNAQkBFhRqYWx0bWFuQGF1cmlzdG9yLmNvbTELMAkGA1UEBhMC
VVMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDKtXD1tqgXxlJvgI10FM0ZvyWukq2I
eXgVhbgOk4k4PbRk1TvrGB04QatXac9soW7yHv6RhoovQ+URaXBEpBYxOE8Tsx+XfKZNkGbWj9bE
dWgi8HPb33rf8eKFuhjx1QEv/YtD7lGIp7RhKWC5kBfvyut8o3XJmJF0hCR1m663wsttrn89dwZc
zLU4JUjbTF0ukM0DbDk55ItDB4dXnW/uRfhrVuemMvbDily+etLCWsuJjtrjRBCQ805eYRHq5Lon
X3oNLdXituSHXLKvq+uChgFN/veDHKpeBnBWmoNtOQnV8fsq5NCz/WswIACeZj+xGmZsWx7fyuze
e78ZePfBAgMBAAGjggGhMIIBnTAMBgNVHRMBAf8EAjAAMA4GA1UdDwEB/wQEAwIE8DCBhAYIKwYB
BQUHAQEEeDB2MDAGCCsGAQUFBzABhiRodHRwOi8vY29tbWVyY2lhbC5vY3NwLmlkZW50cnVzdC5j
b20wQgYIKwYBBQUHMAKGNmh0dHA6Ly92YWxpZGF0aW9uLmlkZW50cnVzdC5jb20vY2VydHMvdHJ1
c3RpZGNhYTE0LnA3YzAfBgNVHSMEGDAWgBTC1ESZoHHPSFa+DI5oOFynt/dFvDAjBgNVHSAEHDAa
MAkGB2eBDAEFAwIwDQYLYIZIAYb5LwAGAgEwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL3ZhbGlk
YXRpb24uaWRlbnRydXN0LmNvbS9jcmwvdHJ1c3RpZGNhYTE0LmNybDAfBgNVHREEGDAWgRRqYWx0
bWFuQGF1cmlzdG9yLmNvbTAdBgNVHQ4EFgQUY4JHedU4owyskKPvw4gOjSyBJZUwKQYDVR0lBCIw
IAYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3CgMMMA0GCSqGSIb3DQEBCwUAA4ICAQCeOjCs
cMFctL6UG8WBsFMIOHc7MpbrX7EIvO34SGVKhrbqS1RTIBQiVVWnQ4VI6qVw/n9dadUv4o1/F23s
0uXE8/lGJAGn51kkw1xHU+0PGODOTWvAQOiPhSmaXG5xM4BgleroGggumd8fHRSKFK7DIdWcMMNb
S6LpMAOUfXYzNBvcHbAcjJMHQ7N8pNXdEQDB9c6yIw4paVD6XDE5VFhLdf6749jGqSWXpyTMjXzr
PMaDyxKiNOtsUrdT/fh8+Xx84nGpwiV9PA9/cGSAPcAc/qMBgPb4Qj9met/RUvCHPWr68Zlirgx4
8W/7TTZFhXKZg3U+zCj4ASOfLJ6WT4PPoM+eLHbB402WNMFkQDmWBH4bMqUcbQWxarMxdQ/jHKTs
JIkvg+rTCbWbDm7hgJbnPEZrJEghy69Opa9+F1HB90AQmb41N1PLZytu8pCGBJufyqjzNU0eyWkH
JCwHDLFhoCENk/vujFCmsJUSh7a6ZMPSXf3PR4TPKkcgs9JBT0dyPGHEfC/Lp9ZHTGSO6zswK1Bd
dBufYi3xqHNBO/s7ft6gpNvht7oKUhVcjM7EmQCA6t2ok44PNfeG8rJZxiDv04IruCbzLFwkPczW
S5uCIuP3PWCfVtMnUPDamMVWAr4Ui/s6fy3TZbPUAPDjFRi7zpkFIKHlCS/HIHNR6Gr1lzCCBvQw
ggTcoAMCAQICEEABif/SaQvad8Lp1U2SCE0wDQYJKoZIhvcNAQELBQAwSjELMAkGA1UEBhMCVVMx
EjAQBgNVBAoTCUlkZW5UcnVzdDEnMCUGA1UEAxMeSWRlblRydXN0IENvbW1lcmNpYWwgUm9vdCBD
QSAxMB4XDTIzMDgxNjE5Mjg0NloXDTMzMDgxMjE5Mjg0NVowOjELMAkGA1UEBhMCVVMxEjAQBgNV
BAoTCUlkZW5UcnVzdDEXMBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTQwggIiMA0GCSqGSIb3DQEBAQUA
A4ICDwAwggIKAoICAQDoqfW8senk2X/L7Viky0ZgZYnwlxqsE/vDQWARa1i7gZ0wRJ7ZOWIbjYDc
csGFBhCb8VLx1dershozyPcOizZ1LxAhstZhpz8KvKc4bHhu1+6ZJftmrDyAELLRu1gkPS0Bvong
GBinxoTNo0XwafmS67jFRtYHe2VQSLvy0t9xRUsgdEeYgCUAnKO5eRVQMmBBNhnsTFtO5FzNmNKn
uw/TDcBbOpGrQ1FSCuOZTHw3njDtZGqiRXSruX3MCpV190CefwryeGLXCsawSz2wMQZkqtjYV9Au
73Zrqg1yDVj9KGKoRnJ8cUcg1Inxs/+Bo3xcM43y2h10yDrSWFTfvPSQhUJwYKHCYJSVQLFbeH9v
xFJeLlewivaKQMGEg8PpnjevzDu8PVVzr9gkWcLubhztussqdAPF+dvyXIYJb/7l6idZkS4NeHAs
rAtcv+UF+SGzSS5F28s376Kx35LUaJeOW4hQOjSj/118F9cyYAd2WlgGdBdaK2PSvH7aANZQfyEh
NNMzk2GP83pHXXeXy+09LkTcIlgXr2rrXepxP+WBp+Ihu4Jh5uZWQkpGUUNqKSjxIpUJ6sDIIgGI
qSY/uBFSp2ff+4OLLS3Z+XQ9gBu1Szd3kQ8PrGXAI5DXayXjM9YppsHld3OojXhoOsLdCji+be0m
AgvbNa6AaSJcT7RF3QIDAQABo4IB5DCCAeAwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8E
BAMCAYYwgYkGCCsGAQUFBwEBBH0wezAwBggrBgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2Nz
cC5pZGVudHJ1c3QuY29tMEcGCCsGAQUFBzAChjtodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3Qu
Y29tL3Jvb3RzL2NvbW1lcmNpYWxyb290Y2ExLnA3YzAfBgNVHSMEGDAWgBTtRBnA0/AGi+6ke75C
5yZUyI42djBfBgNVHSAEWDBWMFQGBFUdIAAwTDBKBggrBgEFBQcCARY+aHR0cHM6Ly9zZWN1cmUu
aWRlbnRydXN0LmNvbS9jZXJ0aWZpY2F0ZXMvcG9saWN5L3RzL2luZGV4Lmh0bWwwSgYDVR0fBEMw
QTA/oD2gO4Y5aHR0cDovL3ZhbGlkYXRpb24uaWRlbnRydXN0LmNvbS9jcmwvY29tbWVyY2lhbHJv
b3RjYTEuY3JsMB0GA1UdDgQWBBTC1ESZoHHPSFa+DI5oOFynt/dFvDBBBgNVHSUEOjA4BggrBgEF
BQcDAgYIKwYBBQUHAwQGCisGAQQBgjcKAwwGCisGAQQBgjcUAgIGCisGAQQBgjcKAwQwDQYJKoZI
hvcNAQELBQADggIBAJXyFF1baV3jUq5o3Q5FIysADRg5knGSFzcliSyYTBd5YZ4FYFZSDxrQ25J8
7EFzq8q9a1lQxNwcj2R3IFNfx5QWU6EApuGwiOgX9igx3EAJuOa8JnSoLUI5zKflmNqTVHSz3b94
UQy/MF+s8+OwbM8+FscUY0CxXRlOEETsW6MFXfliOSIEnQFmm5NraqzYHecXC8DJF6yTxbu1+101
T66oqkp9+EAvU+SXgSIcHDpNxAmbm6XcSQFwEZLOLSctCVeZzLsvCE1Ozr5hvEAstYh07Qm/FtuZ
+M540l2qSydFaI4yD7uH6/SsjQAARQXYzezBauwR8YOTS7PUDWejFUpHzPy4q2JdYdU2jYTst4G7
gW0+y6EQyXIiSEEaKePUrnIiRImK6ySZXDTB7A+td6giMATY61GcJUS9kdCHZ4brFJiLBg9az11c
15e5SbS2bCNAMOIK6NwakjsWmh2jX+C6LJX37ehqQT0GVekYT4nGMBH89MiQ1kFnIQcIWTagA/Qq
FHMhHFlUH5mWyby/6alKXu0ZeODdBRR/Tn39K6awTCVSbQH8P+KbF5kMky9b7IFzJI/fwxr/ZVoE
KCj0aoicm2TTsXgqRUI7MgiLU6hE5ersxFh5yM2IBc8za+kvkB7SeXPhzloFqmayuM2QfrqjsX1F
0CopS11iOE4QVaJmMYICpjCCAqICAQEwTjA6MQswCQYDVQQGEwJVUzESMBAGA1UEChMJSWRlblRy
dXN0MRcwFQYDVQQDEw5UcnVzdElEIENBIEExNAIQQAGYpgQCdfbeJujk4J9zsTANBglghkgBZQME
AgEFAKCCASkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwNTEy
MDgyMjA3WjAvBgkqhkiG9w0BCQQxIgQgpuO7MRYCfZYn5zLV38NqhoKbFORsCL3oKPc5imDAqqQw
XQYJKwYBBAGCNxAEMVAwTjA6MQswCQYDVQQGEwJVUzESMBAGA1UEChMJSWRlblRydXN0MRcwFQYD
VQQDEw5UcnVzdElEIENBIEExNAIQQAGYpgQCdfbeJujk4J9zsTBfBgsqhkiG9w0BCRACCzFQoE4w
OjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUGA1UEAxMOVHJ1c3RJRCBDQSBB
MTQCEEABmKYEAnX23ibo5OCfc7EwDQYJKoZIhvcNAQELBQAEggEAseH3j6CKftiE3ucg2iZ612tx
NOZL7NezteJwvTDw2O++5fjqv2HbG2lJrZPEu2MNviHQNuNqnK444YELYK9auzxkFA7qIONDMIgE
YbfjX7vfWCm7HFehibESztYmxKSTzYGhJy/YuYyug3cEcSRk8q2/TyMAnm4IEWcM5sNA+zD3mbfK
6Z+N23r65MkZlQySoJ0620GSYg5u1IDbVU2LySWEvBrN78KaS6lAYCbs3/R4Wz6T4SHm0/kUjC49
jXbEAcqFiTbu9/D3cCMXrziBr/GF6tvIlKaRAHreFNh2MrM2VYEpDs6ZxIdwozLRtpZKNu+yRWNs
yn3ZFslLz8qe+wAAAAAAAA==
--Apple-Mail=_ACC71318-2940-4497-BA79-7D203D7244E0--


