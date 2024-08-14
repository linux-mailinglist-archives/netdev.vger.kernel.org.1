Return-Path: <netdev+bounces-118540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB725951EB8
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 17:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF761F23236
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA6D1B5824;
	Wed, 14 Aug 2024 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XgPkTXNc"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61821B580C
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649833; cv=none; b=dGI6QLjhuusZlcZfX4tgRJ/cZoxHmt5PM9mThP+ReCPthTmVyWItiYUrS6zFJKGH7VvE71HKNF2j/TutfRZNTU73oM8OK7Ju+JXhBgnZQGfzdk3yr+4C+SDMI1ny3b9DC0zY/L9TG3TC8VIl1hdg9UimdTrNrr3LKZiRed+TrEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649833; c=relaxed/simple;
	bh=ZumYsDCZmNMkpQksJ8p659OKJ3KtAe7xWrm338kFaDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+PXP74Xz7ANuu0q1DwrFT6GDhYXDYiFk2SVc4UWgkdFrGWzsHX4L6UfLD4TggYGckY4OUCsAe4LsXCh5h0Ofr7GEYFS89g3c9seP5RCWlhdN1scDyX/emLI1Pd7xqjtTBBdDYJaLpeTOQrms9dcTeOt0QRlMnaFK1q7W91ferE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XgPkTXNc; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BB91A114E848;
	Wed, 14 Aug 2024 11:37:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 14 Aug 2024 11:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723649830; x=1723736230; bh=E7NQK8pGwDr/SXWkifVBJ5OeYlOA
	2Ziuc367RQ4iMyg=; b=XgPkTXNc0KZWxe1d0FjL/qQGiA/g2d9bnzbJsvnFUKb1
	7SXaXt0SL7FfhPpFKRVlh6tSSWRGp5s/CgvGWuZuYyygnMD+mau061QCXVTHOnLY
	deYZ7AgCESidkmDaFv+8Ko/Xcgk8G9rz9eRoBorBP+ea+GPCTrtojj0l19VCHH1D
	2R/J35oqpWUAwnZGMSRAsYSAnUDCWBs0cMAu/cPW31VaybZUgy1seiLlk0C93t94
	wohhSjFJe423X3SHv4LA+UEQd1UQihPNnf6ZM8p6W5bqA+HJpb7Q4aZPGxkHFiIo
	KQ6QF7ZBK8UdX3kR26FwpWcOMXScmA/Xziu2C0o16A==
X-ME-Sender: <xms:Js-8ZsI17SgBR8AHHzki0zna3rnF_jLFRHpMwg-IMzuDfUa1wB1FFA>
    <xme:Js-8ZsJLGp5j4WTUBpMX1vib-Hhb315HLU3SQvH89RUybC5iVxl4qq6tQPx8FeNcb
    lHes20xgeF-nho>
X-ME-Received: <xmr:Js-8Zsvlevus-CVbQEV6VodRK5ltGUX-tfiFRWBAJH5ble3A9MUkgfn9zbK-3B990KxBdJfCTu6ZuuAxmAx3Br7i-DhrKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieef
    gfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthht
    ohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsohhrihhsrdhsuhhkhh
    holhhithhkohessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhloh
    hfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnih
    esrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhhhshesmhhojhgrthgrthhurdgtohhm
    pdhrtghpthhtohepgihihihouhdrfigrnhhgtghonhhgsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepjhhirhhisehrvghsnhhulhhlihdruhhs
X-ME-Proxy: <xmx:Js-8Zpalz6PujSRP78yQgZyCgdorjNCzyeikv4t24pFY_rLmXrmuvg>
    <xmx:Js-8ZjYJukTTHUvfHhPOX-2k7RNyM-_ZQenOsU6V-ogOG2Z7uiuRqA>
    <xmx:Js-8ZlAMKzrFjsgvbZfL1MSwkUso-qFuH23Hsnb8IzoTzPNrRH8Ttg>
    <xmx:Js-8ZpavwZ2lvmygbFSW6FEQpJCXG6QZFThc6_mr6DBdTQpLKGL7GA>
    <xmx:Js-8ZpzEcUyXjXtsYrqhbaSKxK0aOk9ZHDtlq5S4Zg4EeRwMRRGVYa39>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 11:37:09 -0400 (EDT)
Date: Wed, 14 Aug 2024 18:37:06 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Boris Sukholitko <boris.sukholitko@broadcom.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: Re: [PATCH net-next v2 6/6] selftests: forwarding: tc_actions: test
 vlan flush
Message-ID: <ZrzPIgP5HGmzBuEn@shredder.mtl.com>
References: <20240814130618.2885431-1-boris.sukholitko@broadcom.com>
 <20240814130618.2885431-7-boris.sukholitko@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814130618.2885431-7-boris.sukholitko@broadcom.com>

On Wed, Aug 14, 2024 at 04:06:18PM +0300, Boris Sukholitko wrote:
> Add new test checking the correctness of inner vlan flushing to the skb
> data when outer vlan tag is added through act_vlan.
> 
> Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
> ---
>  .../selftests/net/forwarding/tc_actions.sh    | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/tc_actions.sh b/tools/testing/selftests/net/forwarding/tc_actions.sh
> index 589629636502..65ff80d66b17 100755
> --- a/tools/testing/selftests/net/forwarding/tc_actions.sh
> +++ b/tools/testing/selftests/net/forwarding/tc_actions.sh
> @@ -4,7 +4,7 @@
>  ALL_TESTS="gact_drop_and_ok_test mirred_egress_redirect_test \
>  	mirred_egress_mirror_test matchall_mirred_egress_mirror_test \
>  	gact_trap_test mirred_egress_to_ingress_test \
> -	mirred_egress_to_ingress_tcp_test"
> +	mirred_egress_to_ingress_tcp_test vlan_flush_test"
>  NUM_NETIFS=4
>  source tc_common.sh
>  source lib.sh
> @@ -244,6 +244,26 @@ mirred_egress_to_ingress_tcp_test()
>  	log_test "mirred_egress_to_ingress_tcp ($tcflags)"
>  }
>  
> +vlan_flush_test()
> +{
> +	ip link add x$h1 type veth peer x$h2
> +	ip link set x$h1 up
> +	ip link set x$h2 up

The test already creates the needed topology, there is no need to create
more interfaces. You can use $h1 and $swp1 which are either a veth pair
(default if you didn't configure anything) or two connected physical
ports.

> +
> +	tc qdisc add dev x$h1 clsact
> +	tc filter add dev x$h1 ingress pref 20 chain 0 handle 20 flower num_of_vlans 1 \

Please use $tcflags like other test cases.

> +		action vlan push id 100 protocol 0x8100 action goto chain 5
> +	tc filter add dev x$h1 ingress pref 30 chain 5 handle 30 flower num_of_vlans 2 \

The cover letter says that the bug also exists on egress so I suggest
checking that as well to avoid future regressions.

> +		cvlan_ethtype 0x800 action pass
> +
> +	$MZ x$h2 -t udp -Q 10 -q

For consistency, please invoke $MZ with similar parameters to other test
cases.

> +	tc_check_packets "dev x$h1 ingress" 30 1
> +	check_err $? "No double-vlan packets received"
> +
> +	ip link del x$h1
> +	log_test "vlan_flush_test ($tcflags)"
> +}
> +
>  setup_prepare()
>  {
>  	h1=${NETIFS[p1]}
> -- 
> 2.42.0
> 
> 

