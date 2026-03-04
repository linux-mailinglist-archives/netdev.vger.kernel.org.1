Return-Path: <netdev+bounces-263944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHXnIQNsqGn9uQAAu9opvQ
	(envelope-from <netdev+bounces-263944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:29:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D1520526F
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76A403068D9E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 17:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5513B894E;
	Wed,  4 Mar 2026 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="QnC36x3Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ts0Q+CyL"
X-Original-To: netdev@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0F73BA22A;
	Wed,  4 Mar 2026 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645261; cv=none; b=Uh1k72MYujx5gvo9IRNA0l9cOjwXP8FAZsMaE5RF27TRXOsD61yI4nJ9AE1nrfake0OYIRkT+QKhSp4NBV5ef2poNctnox+Y2TgY38Niv4IPxjQvHQFGqDm8U1x2ft86vq1i3KZrvH4FiRC6aYeXYXtLluUba/uiEzuQGdiG3dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645261; c=relaxed/simple;
	bh=ChRoXIr9yvc9qsnA8M/lFeW4TR0ctexLkYbNu6N5U84=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=fC1MkkZ5bkQwHVpMOW0NbK3sM6paNKxB5ySeg2E0CQPnO9rEnGS2e2dWIWtd2OKyNt5ZF5pZetoFpjW8NEX68jrtrE/2G7/+P7sQ7a9amKknt7b6I+sdTl5HCf1LtNrJjWrLZzCf+/cek5LSU1yGAq53wciFjrJgDML3ImG83kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=QnC36x3Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ts0Q+CyL; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id CF9111300F11;
	Wed,  4 Mar 2026 12:27:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 04 Mar 2026 12:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1772645250; x=1772652450; bh=3hZ85nMdNhByeQ6ZYVQXq
	B9xKZH1h7PxqhN6Br3f/2c=; b=QnC36x3Q0L6xqckhgTvg0RhzwLtbHJl1LbZae
	lQOEj5vSYUTnSoVlsVUeyWZ7BFVXvRbadXEoFjlwbuFmtCNoNr5g6QgGwQhny6EB
	9+TJ1YY5NzwaPEddpx8Dz91sG6J7yavVO6pwgw7K00XnTGDS3NLW2t2kWbKXI/bD
	ktlVMvv3lLGzjkrFKztKz/lOnCzXc+uBHh8LxWeqUrV0j7rKVCgZlB2ojJtQt8z2
	d7rwxR8364Xlmf3EIgKF8a79qS4pel2lSzv450kjZmMyfz6Kcgo0Cj+C0la1LVuH
	RAJl6zvwMmHvuMMDz0X1SnfPo/FXLXgNoyXC5a03JJIhH9prw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772645250; x=1772652450; bh=3hZ85nMdNhByeQ6ZYVQXqB9xKZH1h7PxqhN
	6Br3f/2c=; b=Ts0Q+CyLeHtsjZa2qIsBBXYiazEhphTAUGF1UbKa8iFCnzq+F9Z
	tpFVd3j1u8YHNdSWNkE7XrsA0j2gJqzVSc26ea5hkpBzUPp7HikTyqU8MgT8d5Sn
	K0S/PEf75ZeANH4LYctWTja3+fzREQSau8D4BOrSKlCjqv4jAtKAsgd+2liZrw/f
	yhpkISLwza5cFE2y/otsnbshQlvQPvvhAHgC8Dayj8qkRqyYJdVOppxQqZ7baCCe
	Pxahyc9I55JrrKXD3ZrmWi+grgHLziieNuHHwJ8NTIf08TcgkC3sqeG12qJdllH4
	f8R65rPiQnwJBvcMCC8Z9E2rZ0jDMdrZtnA==
X-ME-Sender: <xms:gWuoaXqk14uE5s0m_TuMf6ts7a1i3iGW40jvSu4pR9Zi_ZfP5HqcrA>
    <xme:gWuoaU0B4tFrUIaiHcZUah8p0Kqq7oYK-qlT7K3Nw0nygkSEH7vmRwyVXFm5slPvH
    sPby8Kgy7liPCAcsrsEpztcXNBGkn-rFcEqJbZ-r4oFfA__sHHhYWDA>
X-ME-Received: <xmr:gWuoabDRjtyrY32qaPOz5eDHSWtQ4mJweZH9YQJ7da5hObUf-gDGexKT6ARICdu4PKP5Iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeguddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepueffvedvvdefudejfeeuudfgtdfgudettdevfeeileffhffghfdtjeekhfeitdek
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgs
    pghrtghpthhtohepfedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrgiioh
    hrsegslhgrtghkfigrlhhlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopehsughfsehfohhmihgthhgvvhdrmhgvpdhrtghpth
    htohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehjohgrmhgrkhhi
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmh
    grihhlrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdp
    rhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephh
    grohhluhhosehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:gWuoaf-EBMU6swfd3wz5-LiaJoCG7pZXDIGa3MJHvemjMva_eYZK7g>
    <xmx:gWuoaZNqTd9KN2XDAKETzPj03As7PqG8KycivG-2S4CbXR-oS_YByA>
    <xmx:gWuoaZGIr2ULQaYIa6nntoUlP4dambGdZS1-5PMwloSv7uFI8a5YCQ>
    <xmx:gWuoaYtTjEINoFXqZu29syBRqZDb08iZ_8KL2A4Cw1Mle9DtJKzvVQ>
    <xmx:gmuoaQPXxPfDAFDGHFskgUiH2pt0TXhr7IpjI4TKmlobe_WeiAlZ6uUc>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 12:27:29 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 0A4769FCB4; Wed,  4 Mar 2026 09:27:28 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 08F399FC67;
	Wed,  4 Mar 2026 09:27:28 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Nikolay Aleksandrov <razor@blackwall.org>
cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
    jiayuan.chen@shopee.com,
    syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
    Daniel Borkmann <daniel@iogearbox.net>,
    Jesper Dangaard Brouer <hawk@kernel.org>,
    John Fastabend <john.fastabend@gmail.com>,
    Stanislav Fomichev <sdf@fomichev.me>,
    Andrii Nakryiko <andrii@kernel.org>,
    Martin KaFai Lau <martin.lau@linux.dev>,
    Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
    Yonghong Song <yonghong.song@linux.dev>,
    KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
    Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
    Clark Williams <clrkwllms@kernel.org>,
    Steven Rostedt <rostedt@goodmis.org>, Jussi Maki <joamaki@gmail.com>,
    linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v4 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
In-reply-to: <aahWymAi_CtRG0gJ@penguin>
References: <20260304074301.35482-1-jiayuan.chen@linux.dev>
 <20260304074301.35482-2-jiayuan.chen@linux.dev> <aahWymAi_CtRG0gJ@penguin>
Comments: In-reply-to Nikolay Aleksandrov <razor@blackwall.org>
   message dated "Wed, 04 Mar 2026 17:59:06 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1293119.1772645247.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Mar 2026 09:27:28 -0800
Message-ID: <1293120.1772645248@famine>
X-Rspamd-Queue-Id: D5D1520526F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263944-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,shopee.com,syzkaller.appspotmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linutronix.de,goodmis.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jvosburgh.net:dkim,jvosburgh.net:email,shopee.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,blackwall.org:email,appspotmail.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Nikolay Aleksandrov <razor@blackwall.org> wrote:

>On Wed, Mar 04, 2026 at 03:42:57PM +0800, Jiayuan Chen wrote:
>> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>> =

>> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
>> check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
>> when the bond mode is round-robin. If the bond device was never brought
>> up, rr_tx_counter remains NULL, causing a null-ptr-deref.
>> =

>> The XDP redirect path can reach this code even when the bond is not up:
>> bpf_master_redirect_enabled_key is a global static key, so when any bon=
d
>> device has native XDP attached, the XDP_TX -> xdp_master_redirect()
>> interception is enabled for all bond slaves system-wide. This allows th=
e
>> path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
>> bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
>> reached on a bond that was never opened.
>> =

>> Fix this by allocating rr_tx_counter unconditionally in bond_init()
>> (ndo_init), which is called by register_netdevice() and covers both
>> device creation paths (bond_create() and bond_newlink()). This also
>> handles the case where bond mode is changed to round-robin after device
>> creation. The conditional allocation in bond_open() is removed. Since
>> bond_destructor() already unconditionally calls
>> free_percpu(bond->rr_tx_counter), the lifecycle is clean: allocate at
>> ndo_init, free at destructor.
>> =

>> Note: rr_tx_counter is only used by round-robin mode, so this
>> deliberately allocates a per-cpu u32 that goes unused for other modes.
>> Conditional allocation (e.g., in bond_option_mode_set) was considered
>> but rejected: the XDP path can race with mode changes on a downed bond,
>> and adding memory barriers to the XDP hot path is not justified for
>> saving 4 bytes per CPU.
>> =

>> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to sla=
ve device")
>> Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@g=
oogle.com/T/
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
>> ---
>>  drivers/net/bonding/bond_main.c | 19 +++++++++++++------
>>  1 file changed, 13 insertions(+), 6 deletions(-)
>> =

>
>IMO it's not worth it to waste memory in all modes, for an unpopular mode=
.
>I think it'd be better to add a null check in bond_rr_gen_slave_id(),
>READ/WRITE_ONCE() should be enough since it is allocated only once, and
>freed when the xmit code cannot be reachable anymore (otherwise we'd have
>more bugs now). The branch will be successfully predicted practically alw=
ays,
>and you can also mark the ptr being null as unlikely. That way only RR ta=
kes
>a very minimal hit, if any.

	Is what you're suggesting different from Jiayuan's proposal[0],
in the sense of needing barriers in the XDP hot path to insure ordering?

	If I understand correctly, your suggestion is something like
(totally untested):

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_ma=
in.c
index eb27cacc26d7..ac2a4fc0aad0 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4273,13 +4273,17 @@ void bond_work_cancel_all(struct bonding *bond)
 static int bond_open(struct net_device *bond_dev)
 {
 	struct bonding *bond =3D netdev_priv(bond_dev);
+	u32 __percpu *rr_tx_tmp;
 	struct list_head *iter;
 	struct slave *slave;
 =

-	if (BOND_MODE(bond) =3D=3D BOND_MODE_ROUNDROBIN && !bond->rr_tx_counter)=
 {
-		bond->rr_tx_counter =3D alloc_percpu(u32);
-		if (!bond->rr_tx_counter)
+	if (BOND_MODE(bond) =3D=3D BOND_MODE_ROUNDROBIN &&
+	    !READ_ONCE(bond->rr_tx_counter)) {
+		rr_tx_tmp =3D alloc_percpu(u32);
+		if (!rr_tx_tmp)
 			return -ENOMEM;
+		WRITE_ONCE(bond->rr_tx_counter, rr_tx_tmp);
+
 	}
 =

 	/* reset slave->backup and slave->inactive */
@@ -4866,6 +4870,9 @@ static u32 bond_rr_gen_slave_id(struct bonding *bond=
)
 	struct reciprocal_value reciprocal_packets_per_slave;
 	int packets_per_slave =3D bond->params.packets_per_slave;
 =

+	if (!READ_ONCE(bond->rr_tx_counter))
+		packets_per_slave =3D 0;
+
 	switch (packets_per_slave) {
 	case 0:
 		slave_id =3D get_random_u32();

	-J


[0] https://lore.kernel.org/netdev/e4a2a652784ec206728eb3a929a9892238c61f0=
6@linux.dev/

---
	-Jay Vosburgh, jv@jvosburgh.net

