Return-Path: <netdev+bounces-227331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AD6BACAAF
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 13:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0663A5505
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 11:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178E8268688;
	Tue, 30 Sep 2025 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="RD7indjH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABEE240611
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759231221; cv=none; b=Jg7XU9vp/aIck/tu1TmMhaL3lOqjn1bK8I4bwL58b01w4Nmu2kZyPb9gbNvHlidD/+1P+eH3Ckpt5s1BpM54i9cZcpTX67VwrKtXbSY7vC9WUXMM0+ivwXnzeAtiHWX18NCSc4OfwETIk+JJmPQFkDBld8IRjhmfaIOpm1yY3lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759231221; c=relaxed/simple;
	bh=aGyJPngcI2GUynbKEOhKOF674Rzhog3Ql+uj/AK6Rbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZfa2slOyDQPXkA8Xr5aSI6kPsr1jB3rE9uHM7dRS2AffKQryjDMXPGTKaWNmqVzDJg6aXkyTLw/z9CS1dummNNoTXXOXw4hEqdhMGD2yYcq8/w4a/82Guf0Sy4hl/EQpNylOdw1xIvnkWURgYpKG+h3d29eXlUC164GF5qjpC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=RD7indjH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so11480615e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1759231217; x=1759836017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WYHBTgmdmHErC6+UjFY3X1Y//FB5ql6lj7rgayPtwFg=;
        b=RD7indjHYPL9dbNqUMd5GJnUVqKSWUOdBDe6f5aJciVE+Tw0TrnmWWHWJUZnt/N2Gx
         FlVQspCqR0Ss+lFsGBc1Dj8LR3GH4FWVML3EM+PkANZzIzMSa4recFtQneKun5SMu4/6
         v0imlsBqet5V7TSk2x2LxCOYjeV8Vq/dhjIs1a56OOPQkFIx7DQmv5oVHQrFwg+tyOh2
         vAcosyrJcspK+UVIFmDrk8I4iBdZuGInzJD2ncdMkfAHGr9itjLRol2n141p1T+Grc0/
         GSLg4zM7ZWKtNlagEy/GRTgQ+R9myW4CkCwB4QCk08tONdhG9LJSPFKWay10lZPLSVdF
         /+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759231217; x=1759836017;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYHBTgmdmHErC6+UjFY3X1Y//FB5ql6lj7rgayPtwFg=;
        b=ZmvINBlhJ8Vu0L7NBoy9Dk3evQNEA0bjaa5ZpLTAcn/Ni+TOBTkCU1jGE2PpuRBanB
         QhvJcL1LlQLrVFFyDr0Ktj9C+KE9rGOL4eoV0llB58LqAnlOXj7tq4Yw54mKP5wiw4+q
         +oPYYjspNkqvMyyqfAaYmTn6wy2mwbhBkf2hyUMQY6oCjT2vSnVvkkxCYzZ3nHtjaX8P
         DlGCiyuhinABC431CmoVe7662slVHEBZFdjBuB4nIF9BbC3T5dLQJCo4MdDsv6PTDH4P
         Qd1Q/aZtdu+66mRER78KWceaX+pi0AFvP9YgrFjeA0940jp0WJdUcc860sdM5OBB2cmo
         ziSg==
X-Gm-Message-State: AOJu0YxXj964T2eK5W83s+y+HNEG0YRZIMPAGx+UyNGP7GCkjLa06BE2
	SCq1UV+FihcfDkxt1aIqSmyqCGZgJUN850KB3RCILhWxE5rE+nzWkb7FP/bW1PIJ72JXqsWKByo
	xBH9fwRepmbcHaHSIxLYlVO/lqNaTMR0Y/xp1HEl/+jGAT05kaRU=
X-Gm-Gg: ASbGnct/yLX/SoSA4F6CCiOqxNiUhLDBkJpoGxdHAnPFR/k5A37TiqGamVan4HirPq4
	mp4cp/JenvO8OqaDn7QE8++fvT2vAWHSz2r+sesGWknzLaU3vsyNAIzpYhSTgBVtPVTNHsSSZBb
	H5C/MmmVcMXcOPTSGBgfRhdvlJPldqM8JxRkzEksWK/3zbuTC4OLV5herkaVA3emTvfwjMk5snq
	nHjaZnJnbagLCla4YWDJYIt27sbSGqmhgCizMt5vDj4LJ5LhsTIL1olMwlmuJNf/ZFGhIabXKBj
	0eVZ1QdtXLwWZTsjGAGT5HORkv89udlHRSsg1MRWP/edajQTfILvIqX5iOy51FXE70x+jJ8if0d
	z91mpustJOasGyFVD4RzSy/Ds87kVL7anQ+lUFSNYe+g13RksZ9v/YY/fkg7n5W6G/QI57DzUaT
	27QycFKiDUkyL6e1/gPQ==
X-Google-Smtp-Source: AGHT+IHokmu9/1ydi7cUDt2vPOg7tfZKU3YLML2+mLVZJ7ibXUdPL5HAOmJK7eRxubhFSfT6/8bbew==
X-Received: by 2002:a05:6000:2dc9:b0:3ec:ce37:3a6a with SMTP id ffacd0b85a97d-40e4458ce65mr18578876f8f.22.1759231203909;
        Tue, 30 Sep 2025 04:20:03 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:8f94:27ec:8b3:19cd? ([2001:67c:2fbc:1:8f94:27ec:8b3:19cd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f64849sm51890465e9.11.2025.09.30.04.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 04:20:03 -0700 (PDT)
Message-ID: <a21498ff-4dd0-4b3a-9b2e-9b932b5925ad@openvpn.net>
Date: Tue, 30 Sep 2025 13:20:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] selftest:net: Fix uninit return values
To: Sidharth Seela <sidharthseela@gmail.com>, sd@queasysnail.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, willemdebruijn.kernel@gmail.com, kernelxing@tencent.com,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20250930100656.80420-2-sidharthseela@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250930100656.80420-2-sidharthseela@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Thanks a lot for fixing this - I hadn't see the warnings with gcc.

On 30/09/2025 12:06, Sidharth Seela wrote:
> Fix functions that return undefined values. These issues were caught by
> running clang using LLVM=1 option.
> 
> 
> Clang warnings are as follows:
> ovpn-cli.c:1587:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>   1587 |         if (!sock) {
>        |             ^~~~~
> ovpn-cli.c:1635:9: note: uninitialized use occurs here
>   1635 |         return ret;
>        |                ^~~
> ovpn-cli.c:1587:2: note: remove the 'if' if its condition is always false
>   1587 |         if (!sock) {
>        |         ^~~~~~~~~~~~
>   1588 |                 fprintf(stderr, "cannot allocate netlink socket\n");
>        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   1589 |                 goto err_free;
>        |                 ~~~~~~~~~~~~~~
>   1590 |         }
>        |         ~
> ovpn-cli.c:1584:15: note: initialize the variable 'ret' to silence this warning
>   1584 |         int mcid, ret;
>        |                      ^
>        |                       = 0
> ovpn-cli.c:2107:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
>   2107 |         case CMD_INVALID:
>        |              ^~~~~~~~~~~
> ovpn-cli.c:2111:9: note: uninitialized use occurs here
>   2111 |         return ret;
>        |                ^~~
> ovpn-cli.c:1939:12: note: initialize the variable 'ret' to silence this warning
>   1939 |         int n, ret;
>        |                   ^
>        |
> 
> 
> Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
> ovpn module")
> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
> ---
> v4:
> 	- Move changelog below sign-off.
> 	- Remove double-hyphens in commit description.
> v3:
> 	- Use prefix net.
> 	- Remove so_txtime fix as default case calls error().
> 	- Changelog before sign-off.
> 	- Three dashes after sign-off
> v2:
> 	- Use subsystem name "net".
> 	- Add fixes tags.
> 	- Remove txtimestamp fix as default case calls error.
> 	- Assign constant error string instead of NULL.
> 
> 
> diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
> index 9201f2905f2c..20d00378f34a 100644
> --- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
> +++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
> @@ -1581,7 +1581,7 @@ static int ovpn_listen_mcast(void)
>   {
>   	struct nl_sock *sock;
>   	struct nl_cb *cb;
> -	int mcid, ret;
> +	int mcid, ret = -1;

ret goes uninitialized only under the "if (!sock)" condition, therefore 
I'd rather assign ret a meaningful value instead of -1.

How about adding "err = -ENOMEM;" directly inside the if block?

>   
>   	sock = nl_socket_alloc();
>   	if (!sock) {
> @@ -1936,7 +1936,7 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
>   {
>   	char peer_id[10], vpnip[INET6_ADDRSTRLEN], laddr[128], lport[10];
>   	char raddr[128], rport[10];
> -	int n, ret;
> +	int n, ret = -1;

Same here.
ret goes uninitialized only under the "CMD_INVALID" case.

How about adding "ret = -EINVAL;" inside the affected case?


Both values are returned by ovpn_run_cmd() and then printed as 
strerror(-ret).
If we blindly use -1 we will get "Operation not permitted" which will 
confuse the user IMHO.

Thanks a lot!

>   	FILE *fp;
>   
>   	switch (ovpn->cmd) {

-- 
Antonio Quartulli
OpenVPN Inc.


