Return-Path: <netdev+bounces-270063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIPID6qyvWlBAgMAu9opvQ
	(envelope-from <netdev+bounces-270063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:48:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DB22D2E1018
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4269A301C559
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A323644BE;
	Fri, 20 Mar 2026 20:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Esq0mgpv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VCZ/AHdp"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDEF36403C;
	Fri, 20 Mar 2026 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039719; cv=none; b=myXTy5McB3+WYKvLBeSpQNe1afXzZIf8/B7P9D2+Mo584R3R37RvhYtHmZg+elS8YRve1cFMwqqNxd82EJAr5dPU9jGRwfckzCRMKVCQHw/BQdm4sZj62trRD0wD88hOezR34+OSSbycrwizV6bJvkCtgUeYk1lVjPA3IzAppe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039719; c=relaxed/simple;
	bh=6iJKeRVvfZKtvhtpJrPt73DDKKzzdGV+KggsGp531mw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qSLZCmlLo6daVT1rOYXZXYs2MP5Lq08/EjXnr5/s9DkA8ycLpz9p/8wpcfT+InZAije8qiYYg21aQrdHqdxd8FmE6N0B3LaFH2cM3qjJ0ZIUQpzEMriVWrgTuRkkdeTrrXZskUhCnG1tqji+wg4gOJS6djLR2fwCvbdTY9fVCI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Esq0mgpv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VCZ/AHdp; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D37501D000B2;
	Fri, 20 Mar 2026 16:48:34 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 20 Mar 2026 16:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774039714;
	 x=1774126114; bh=MR438byzDRVcyRIAzP4AWEVh8CmGgC39iq9wYYJZ1E8=; b=
	Esq0mgpv1o2fwCKdLQyDCSUnC0nd8bc2XeMLb7OWaYCz9Hc7t0js2gmCgmnspy4n
	DkRKgcdQO9fh264uVmWa9KukQ2aRXANjtGfcsz8f5g/RPmlTuGvxAVMiMhErKv8E
	VrsNcR1QXueHzgTtNkCmcLptynczYll8xaJ7rTlwBH33/t2K5hBsJX0KjKwP+ph5
	nOiBCqBJLZF+ZjmxV8uAaVoe76O0RYPG5Og0a49e299H1X8WC/mXDnbNN6YkZv1I
	ACWTiLEv0UHsY3m37jMXSYk9rEmuNnWERxacPOrWnRfFtfL2omZIEglMWCmFdU+o
	KuYNynbJ3JgigK3eXsv5Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774039714; x=
	1774126114; bh=MR438byzDRVcyRIAzP4AWEVh8CmGgC39iq9wYYJZ1E8=; b=V
	CZ/AHdpsPj8Tcw2UrJoFF04ip4tlZ655w87p5Y4nBcodWG9rQBYoJUtpYpd82/gm
	TeQXea2G8hLq0l9DBOoh27js0OiXcwhKgfrV/NO5UBenyZYfCeSPVKaui7scTrjA
	bYvLVTmyGSLyAOEHRJE7tbomTlNWnOfZH1YEVKpZRtE39IjEJ+T4njiqLdXrK57V
	8QSMNDXTf5mYIdgIvydpKZ9FFNMThBA4GTd4VvgHZ7gn1/NyHeb+zm6upsdLhs5W
	vz4JjKG2KZeqXKqrFPAXhxWAll8DktgR9QuGl7r8HNWMRAEXzMX2Zkbdec9vJS1Z
	Ji+pTX2eCjtvircfV1/sA==
X-ME-Sender: <xms:orK9aUKqbKfJgMqo6LBQsfCAUdNZyiBKeeYHXJSoOmfYA5w4ITVDYA>
    <xme:orK9ae-dovZOJUe9Yl1pQIxvVgrdEOqE9_hdUE-TN2-e_5GgjJv5qsTFwnhX9Xvt-
    JXn4aQh0FBov-QcKZFNT3GUf2fU_-jPJRih7R-9OZoqmchKRV0U3n5X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepkedvuefhiedtueeijeevtdeiieejfeelvefffeelkeeiteejffdvkefgteeuhffg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghrvghtthdrtg
    hrvggvlhgvhiesrghmugdrtghomhdprhgtphhtthhopehlihhnuhigqdhnvghtqdgurhhi
    vhgvrhhssegrmhgurdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfth
    drnhgvthdprhgtphhtthhopehlvghithgrohesuggvsghirghnrdhorhhgpdhrtghpthht
    ohepvggtrhgvvgdrgihilhhinhigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhhitg
    hkrdguvghsrghulhhnihgvrhhsodhlkhhmlhesghhmrghilhdrtghomhdprhgtphhtthho
    pegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhushhtihhnsh
    htihhtthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhhorhgsohesghhoohhglhgv
    rdgtohhm
X-ME-Proxy: <xmx:orK9aVqhBiSmLvglClMV_DRg4Luags_lTnYYtZgkubxrOPOwENKpvQ>
    <xmx:orK9aTjexPJt4yHR9X8asqkwyPrzyIrpbkW1iRyLKEk0STjl9mIM6Q>
    <xmx:orK9advULLJthfVwVRnxjV-BzfsxrhUFrq3R5GX6D0SskPcK00rSWw>
    <xmx:orK9aU1NqpvEtosOzfTaiR42howqM6_E_H9PWvR7ZJTPBbHZVSeJfw>
    <xmx:orK9aUg1kd-iA2cr6GkN4mcHLjFTaqFABlEEkAoRDps2_U7VZ40EJM7Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0F04A700069; Fri, 20 Mar 2026 16:48:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aywyuz1KiUOB
Date: Fri, 20 Mar 2026 21:48:13 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Edward Cree" <ecree.xilinx@gmail.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Nathan Chancellor" <nathan@kernel.org>,
 "Jeff Garzik" <jgarzik@redhat.com>,
 "Ben Hutchings" <bhutchings@solarflare.com>
Cc: "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Brett Creeley" <brett.creeley@amd.com>, "Breno Leitao" <leitao@debian.org>,
 "Kees Cook" <kees@kernel.org>, Netdev <netdev@vger.kernel.org>,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Message-Id: <61de3aea-26b3-4c00-8598-3a137ebef1bc@app.fastmail.com>
In-Reply-To: <90a03d3c-def3-4e34-89a0-6e952d3b0d7a@gmail.com>
References: <20260320151924.3474821-1-arnd@kernel.org>
 <90a03d3c-def3-4e34-89a0-6e952d3b0d7a@gmail.com>
Subject: Re: [PATCH] net: sfc: avoid format string warning
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-270063-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,solarflare.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,google.com,amd.com,debian.org,kernel.org,vger.kernel.org,lists.linux.dev];
	NEURAL_HAM(-0.00)[-0.980];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,lkml];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim,app.fastmail.com:mid]
X-Rspamd-Queue-Id: DB22D2E1018
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026, at 20:04, Edward Cree wrote:
> On 20/03/2026 15:19, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>=20
>> Three sfc drivers contain the same *_fill_test() function that takes
>> a format string argument that gets passed down to snprintf(), produci=
ng
>> a warning with clang-22:
>>=20
>> drivers/net/ethernet/sfc/falcon/ethtool.c:227:60: error: diagnostic b=
ehavior may be improved by adding
>>       the 'format(printf, 7, 8)' attribute to the declaration of 'ef4=
_fill_test' [-Werror,-Wmissing-format-attribute]
>>   210 |                 snprintf(test_str, sizeof(test_str), test_for=
mat, test_id);
>>       |                                                              =
            ^
>> drivers/net/ethernet/sfc/falcon/ethtool.c:210:13: note: 'ef4_fill_tes=
t' declared here
>>=20
>> Rework these to take a varargs based test_format that allows better
>> type checking and avoids this warning.
>>=20
>> Fixes: 3273c2e8c66a ("[netdrvr] sfc: sfc: Add self-test support")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I'm not convinced this is an improvement.  The function takes *two* pr=
intf
>  format strings (unit_format and test_format), and this only annotates=
 and
>  varargs-ifies one of them (and doesn't harden the unit_format, which =
has
>  the considerably more worrying-looking "if it has a % in, assume it t=
akes
>  precisely one int argument").

Right, I took a bit of a shortcut there. How about changing it
so the other format string is just a name that gets joined with the
number?

diff --git a/drivers/net/ethernet/sfc/falcon/ethtool.c b/drivers/net/eth=
ernet/sfc/falcon/ethtool.c
index 1ae8acb8fdc8..a0064eadff41 100644
--- a/drivers/net/ethernet/sfc/falcon/ethtool.c
+++ b/drivers/net/ethernet/sfc/falcon/ethtool.c
@@ -200,7 +200,7 @@ static void ef4_ethtool_set_msglevel(struct net_devi=
ce *net_dev, u32 msg_enable)
  * @strings:		Ethtool strings, or %NULL
  * @data:		Ethtool test results, or %NULL
  * @test:		Pointer to test result (used only if data !=3D %NULL)
- * @unit_format:	Unit name format (e.g. "chan\%d")
+ * @unit_name:		Unit name format (e.g. "chan\%d")
  * @unit_id:		Unit id (e.g. 0 for "chan0")
  * @test_format:	Test name format (e.g. "loopback.\%s.tx.sent")
  * @test_id:		Test id (e.g. "PHYXS" for "loopback.PHYXS.tx_sent")
@@ -208,9 +208,9 @@ static void ef4_ethtool_set_msglevel(struct net_devi=
ce *net_dev, u32 msg_enable)
  * Fill in an individual self-test entry.
  */
 static void __printf(7, 8)
- ef4_fill_test(unsigned int test_index, u8 *strings, u64 *data,
-			  int *test, const char *unit_format, int unit_id,
-			  const char *test_format, ...)
+ef4_fill_test(unsigned int test_index, u8 *strings, u64 *data,
+	      int *test, const char *unit_name, int unit_id,
+	      const char *test_format, ...)
 {
 	char unit_str[ETH_GSTRING_LEN], test_str[ETH_GSTRING_LEN];
=20
@@ -222,11 +222,11 @@ static void __printf(7, 8)
 	if (strings) {
 		va_list arg;
=20
-		if (strchr(unit_format, '%'))
+		if (unit_id >=3D 0)
 			snprintf(unit_str, sizeof(unit_str),
-				 unit_format, unit_id);
+				 "%s%d", unit_name, unit_id);
 		else
-			strcpy(unit_str, unit_format);
+			strcpy(unit_str, unit_name);
 		va_start(arg, test_format);
 		vsnprintf(test_str, sizeof(test_str), test_format, arg);
 		va_end(arg);
@@ -236,9 +236,9 @@ static void __printf(7, 8)
 	}
 }
=20
-#define EF4_CHANNEL_NAME(_channel) "chan%d", _channel->channel
-#define EF4_TX_QUEUE_NAME(_tx_queue) "txq%d", _tx_queue->queue
-#define EF4_RX_QUEUE_NAME(_rx_queue) "rxq%d", _rx_queue->queue
+#define EF4_CHANNEL_NAME(_channel) "chan", _channel->channel
+#define EF4_TX_QUEUE_NAME(_tx_queue) "txq", _tx_queue->queue
+#define EF4_RX_QUEUE_NAME(_rx_queue) "rxq", _rx_queue->queue
 #define EF4_LOOPBACK_NAME(_mode, _counter)			\
 	"loopback.%s." _counter, STRING_TABLE_LOOKUP(_mode, ef4_loopback_mode)
=20
@@ -276,11 +276,11 @@ static int ef4_fill_loopback_test(struct ef4_nic *=
efx,
 	}
 	ef4_fill_test(test_index++, strings, data,
 		      &lb_tests->rx_good,
-		      "rx", 0,
+		      "rx", -1,
 		      EF4_LOOPBACK_NAME(mode, "rx_good"));
 	ef4_fill_test(test_index++, strings, data,
 		      &lb_tests->rx_bad,
-		      "rx", 0,
+		      "rx", -1,
 		      EF4_LOOPBACK_NAME(mode, "rx_bad"));
=20
 	return test_index;
@@ -308,11 +308,11 @@ static int ef4_ethtool_fill_self_tests(struct ef4_=
nic *efx,
 	enum ef4_loopback_mode mode;
=20
 	ef4_fill_test(n++, strings, data, &tests->phy_alive,
-		      "phy", 0, "alive");
+		      "phy", -1, "alive");
 	ef4_fill_test(n++, strings, data, &tests->nvram,
-		      "core", 0, "nvram");
+		      "core", -1, "nvram");
 	ef4_fill_test(n++, strings, data, &tests->interrupt,
-		      "core", 0, "interrupt");
+		      "core", -1, "interrupt");
=20
 	/* Event queues */
 	ef4_for_each_channel(channel, efx) {
@@ -327,9 +327,9 @@ static int ef4_ethtool_fill_self_tests(struct ef4_ni=
c *efx,
 	}
=20
 	ef4_fill_test(n++, strings, data, &tests->memory,
-		      "core", 0, "memory");
+		      "core", -1, "memory");
 	ef4_fill_test(n++, strings, data, &tests->registers,
-		      "core", 0, "registers");
+		      "core", -1, "registers");
=20
 	if (efx->phy_op->run_tests !=3D NULL) {
 		EF4_BUG_ON_PARANOID(efx->phy_op->test_name =3D=3D NULL);
@@ -343,7 +343,7 @@ static int ef4_ethtool_fill_self_tests(struct ef4_ni=
c *efx,
 				break;
=20
 			ef4_fill_test(n++, strings, data, &tests->phy_ext[i],
-				      "phy", 0, "%s", name);
+				      "phy", -1, "%s", name);
 		}
 	}
=20

> I don't like splitting the specifiers/return type from the function na=
me
>  like this.  It's not Linux style[1].
> (From a quick poke around the tree, there seems to be less consensus on
>  where the __printf attribute goes =E2=80=94 some put it on its own li=
ne before
>  `static`, some would put it between `static` and `void`=E2=80=A6 sigh=
.)
>
> [1]: https://lore.kernel.org/all/1054519757.161606@palladium.transmeta=
.com/T/#u

There are not a lot of good options here, and splitting the line seems
better than an overlong line to me. I don't really have a strong opinion
on where the __printf attribute should go either, but I do see that
after the return type is probably the least common, so I'll change
that. How about having the specifiers on one line and
the type in front of the name? that seems faily common.

static __printf(7, 8)
void ef4_fill_test(unsigned int test_index, u8 *strings, u64 *data,

    Arnd

