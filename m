Return-Path: <netdev+bounces-95547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7378C2961
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 19:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC841C219E7
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 17:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2F818637;
	Fri, 10 May 2024 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cDpuQL9r"
X-Original-To: netdev@vger.kernel.org
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB7F17BCE
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362631; cv=none; b=Se2dMbo6tTUoxBhUUq/wqeLJHtPEvaPtXImVY3rdfhnFKAYgYMRoPCb4c3PxG0g+2xTFzdih6xT8x4CWcSmsnhL8GXkLbTdCuEvqiOjd5pFTvfuTTP9lV2JFuiMsTKCzUEpS2U+PTwt+f5Pw1TLQsmCrldNJ9enFgEKVU86CgjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362631; c=relaxed/simple;
	bh=nbS0NFyQWKVJ8zybIo3tRhgmP3SJLlTtFIYwpJ7OUGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mhEZENiy2i2iGfxcKtcgIZuZRSpPQF79YiuiLwTyYVIZ26OWnhY8ekeSB5NlKtBgE9Jb15eek1VEnxMArqjlHkOQy4g37FqUz/nA34+v3zMcCciz2rkw7Js6CGyMAwGgnsXjbJ6JN64+5eNPK46W685nYQzE0C++gBF/PIt0uZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=cDpuQL9r; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715362628; bh=M+YhqPaNMtbKNduj65NH948WF7xqp+28j066o2H9ml0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=cDpuQL9rAJtyWAoxha1LsrSfCjUeeyPFWxJN6XkbzlHXt+kG0KjOA5zsYSnFYDP5kz/dwG5fXITIpnbkVDKW3MseBzdBcfICtcipA/pTA10NjgwqVtGMkg9+QUfQ0p8gxXi3u4KQuHsSq6+FWd57cnj6u62sesE/xGEWuwM9vnMD93a51/057k885MJmYdk4xk19lwiqRVvUhabJW8olNxlmGoYmq0hCE4OIf2iZiLfWLVLIqyiqQBa/M7oIsnC957CGAZq3wETKoR6HO9Os8+v3cTJPeIsactN+LEo4IH7sbwrDzAHrX8LeNJwZGU7qFrwGa8PRNy35PSf3OBj4Ag==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715362628; bh=L0Psu7CRzMYyJfiozg+x9H6n5e00WiJSNPvSz6j7IVC=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MAq9u5DfSwotee27BVNC68A+HVnjS/UhGlX9qBpRvZmmLHZTVKdMrddNFTgJ0tgsyJAqPM1Ce4ICp+8p05wdUFJA13jDa3GT3dG8TEtYUr9wPAgoCI+3gvXngk51AohN4Y7W2sy5wjdT+8619Rm0D/Mi8YlHSbvUcAvuajpxR7OhxKDy5soVIg2QZkMRtEwmeHyZmXIC+OlpWdgC53VqR5aHRkav98SKqJFWmZl3p2x4SmwPGC7ypFVAqprtuQtMdX6w03BzoenVX3mEkI5X7PFAhyckgnMkSte1Fok0QsgU78rAjPcW6MR97NRnRe7y7L1DJrrJJhHiBOio7dvj+g==
X-YMail-OSG: Llnl2m0VM1leCqOrj0np.VysfM6ZDUlvecvVCpJa3jGWcULetqgP8on4uL83U9N
 fCfaV0t2Hqg1Ckk3T.XxDVN8MbKFhXcFS3lEhUlwoM_RX65CPW5jpAWXUC9Ud79gCsQYvTg5VhtB
 RQSiG6iBPij_zJhRmfHTjQ93XyebYScM1lt_fo.6DKnl9kFzrEF0SXkziYXODh9MDjCSJLQS.mYt
 wqZ9ZFMOub3zAUxIVGMbSxLVJXiReNGAhc6fnqb1UDFZhyShy6j36iTIO5QdBlL1F8psVVB3tkZr
 SQVeov0cI3bpZ.FIqa6ooiIHp8lORye1Ktu6Y8IwekxLfJi6E.KSYSFXRUsgDveQr4XZF5BHbO.S
 vTw5Rps7HyW1gxBlxQIW7zEpJLbID5BMRubifruAqY5cSdgh_81k_QJy2PtnI2jXM3nI9rtDeZYt
 x8geOkoRbQ7zsyDlzLrPnz07vyW29pZU5v.Ba1CcKfRhlcdpal4IqaDo1agY4ZbQAdnPfrNOLI64
 FMj8HBgwNTYbvfXl1eBjqNQhVpOkrpBFFUsHUlBTaAYzU08fmLSjDEkNWtvjcYSn2FROeE5EqPPL
 t9BOsnFGc3UGHqbX_P.o5f.wF9P42GL0B9GfLcqrEMtSuQcnpGbhqKzewsx50jBY8rxZMNf6AFzD
 rlqDnqzOQB0VAgF4sc24Lc9saNIYEFBfOs7t7Ad2Z_EsekihYFuSDIRzdXd2R4xFGpHroB.rKOt3
 swVrO6MZYygRPm.sXi3OgaSmzQ1lLZDnOU2zAYA94Qc9arHiXrHjbiP_sUhFbWgOIh1jLxgzXiWr
 vA.k0UOHgrIDm.GK_SxklhgYspuNlpJos7Uxu2t3pqILa2IrmJ2j7MBjiJFiraiEzI7c3XXrgUTj
 oNNoXzv97_FFOgw3a.k04x9zwpsd2uLmqR8ZbIPtamrcNe_eQMq8P7Rq.L8ikccD3kElDwUrGRCc
 Ij0kJGSWuF7Ozw_QTfc8n6vgFjeKBarbZJCovNXKLD2pIcjQ64HpVQNoftl.X2Pa27LVc6FKprQC
 YxZ8uFUdg5pYdGiR0Ej30avYm8v68PEWwIYcayyVVBwMo1r5_EVzQHwBq2toZ8xXO1rnthL2K8gZ
 2HR31kp0CYzdE2O_HoNCn3nw8j1ZEJuRwZ3JgvJAMtRNaHbiDPz8l.IA934GZkbs9.u6JXNszbhY
 o95o2QZGTJo9x7Zoye46_QEvwohjkmIthtDNxriRZNQYKD9J4htdjJuF99zbzmn6CbSFE4V_uCtE
 z8VqFLxUPuw7iYYRYH4u7Y8z2BkkUOjqszGYGEKCWNHcB62okD2OMJw5fsDko_6eFSN.gaj33aGA
 QUbrt.4KGBVD.t4GCEC_U18iW43H1TPZC.S8XpkpbHDWKdRPEUV1_Kf4JhHy8wggKp7emfG.c754
 .DFHMZrOiH5urRYePhKvPkAztnuv3iYhV38ruH6wmbCRCsQW.GjWq73XulJoYQtPMYhN33t.UGma
 xCaPRDnNoufZO_Jc62gwIeZG8qq2tgfTBc1lDboQOVPby_T5qKGuRgTZjxKdD3gmvBcbWiJ2LBp_
 74lIlozM4e3rDbRhFl9CyNwjOr.5Ngs_n2cRDNCxyP7EV2.RvqQlKserUiHRwN6YclYIU9aytBxE
 PkPOweynFJkL9_7TT7.BzhrLDjr2NEiRehL0QDDcdntb5dtn1lSS24dHPJ.NBI2rJMGtOTUO485z
 7.87aqIydLvWnMdHmNn9abi.vbPmW1PTMZjEbdEtOpMFbQgew5gzv0sQYNwr8Ue007xIGiju9PoR
 qRbWPDhKO.uRV_RWu7wFzn_8AXDsLyndonhYzMS7aujA4Qndoa6qAeQAij6tujaAKn_30Yoccn4h
 PADw7dkRM5kztZvu9N7cxcq5W7Mg2SlM3yl.Hgf1WxgjS5losm9B3U1gcjHGucMPPtWJDht1bG7w
 OBBN13TWEtMgeaqP7LSdkDUPraaC5kUk_A1wWm_jKC4ZeKmpcGXGnh8xueDzRil54Kp3FzgXdA25
 B4wCY28d6UVHstyqJufbMW0pFpkNsK1TpV0DqmYpYyfzjV6P0S4ZVbYNiUiUZvW9hjG.6QMTSmLG
 _UqkaAI.WsYdK01of_ntwIOXSDyhr9UQ9sn41hsHx9VPAeIMY27g64x3TAXxU_7eFABE3kN53WiL
 jC31bhNUUlugqZ5.LNQR2vZgFjT9F7XpuyQWS.dkELkMzGdXlTzdtFcMzeHNKewSTL.SP6mdlTax
 4n0Mx_cHn_mBy3Y2vkEJZx8tmjJqI74_xTKYrBC.HEC2KtpoadH8.8jNOBMuKpUREgYmdq0Z6yTY
 RzY6vhDrjEk7cEQoz
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 198613d8-8508-4d2c-a134-c3f3fb333720
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 10 May 2024 17:37:08 +0000
Received: by hermes--production-gq1-59c575df44-zhcxz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6c8f8389b081ccaab6fc52159097358e;
          Fri, 10 May 2024 17:37:03 +0000 (UTC)
Message-ID: <825f4a1c-9cc0-4ab4-8b80-3b704e55b681@schaufler-ca.com>
Date: Fri, 10 May 2024 10:37:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] netlabel: fix RCU annotation for IPv4 options on
 socket creation
To: Davide Caratti <dcaratti@redhat.com>, Paul Moore <paul@paul-moore.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 Xiumei Mu <xmu@redhat.com>, Ondrej Mosnacek <omosnace@redhat.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <f4260d000a3a55b9e8b6a3b4e3fffc7da9f82d41.1715359817.git.dcaratti@redhat.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <f4260d000a3a55b9e8b6a3b4e3fffc7da9f82d41.1715359817.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22321 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/10/2024 10:19 AM, Davide Caratti wrote:
> Xiumei reports the following splat when netlabel and TCP socket are used:
>
>  =============================
>  WARNING: suspicious RCU usage
>  6.9.0-rc2+ #637 Not tainted
>  -----------------------------
>  net/ipv4/cipso_ipv4.c:1880 suspicious rcu_dereference_protected() usage!
>
>  other info that might help us debug this:
>
>  rcu_scheduler_active = 2, debug_locks = 1
>  1 lock held by ncat/23333:
>   #0: ffffffff906030c0 (rcu_read_lock){....}-{1:2}, at: netlbl_sock_setattr+0x25/0x1b0
>
>  stack backtrace:
>  CPU: 11 PID: 23333 Comm: ncat Kdump: loaded Not tainted 6.9.0-rc2+ #637
>  Hardware name: Supermicro SYS-6027R-72RF/X9DRH-7TF/7F/iTF/iF, BIOS 3.0  07/26/2013
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0xa9/0xc0
>   lockdep_rcu_suspicious+0x117/0x190
>   cipso_v4_sock_setattr+0x1ab/0x1b0
>   netlbl_sock_setattr+0x13e/0x1b0
>   selinux_netlbl_socket_post_create+0x3f/0x80
>   selinux_socket_post_create+0x1a0/0x460
>   security_socket_post_create+0x42/0x60
>   __sock_create+0x342/0x3a0
>   __sys_socket_create.part.22+0x42/0x70
>   __sys_socket+0x37/0xb0
>   __x64_sys_socket+0x16/0x20
>   do_syscall_64+0x96/0x180
>   ? do_user_addr_fault+0x68d/0xa30
>   ? exc_page_fault+0x171/0x280
>   ? asm_exc_page_fault+0x22/0x30
>   entry_SYSCALL_64_after_hwframe+0x71/0x79
>  RIP: 0033:0x7fbc0ca3fc1b
>  Code: 73 01 c3 48 8b 0d 05 f2 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 29 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d5 f1 1b 00 f7 d8 64 89 01 48
>  RSP: 002b:00007fff18635208 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
>  RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fbc0ca3fc1b
>  RDX: 0000000000000006 RSI: 0000000000000001 RDI: 0000000000000002
>  RBP: 000055d24f80f8a0 R08: 0000000000000003 R09: 0000000000000001
>
> R10: 0000000000020000 R11: 0000000000000246 R12: 000055d24f80f8a0
>  R13: 0000000000000000 R14: 000055d24f80fb88 R15: 0000000000000000
>   </TASK>
>
> The current implementation of cipso_v4_sock_setattr() replaces IP options
> under the assumption that the caller holds the socket lock; however, such
> assumption is not true, nor needed, in selinux_socket_post_create() hook.
>
> Let all callers of cipso_v4_sock_setattr() specify the "socket lock held"
> condition, except selinux_socket_post_create() _ where such condition can
> safely be set as true even without holding the socket lock.
>
> v5:
>  - fix kernel-doc
>  - adjust #idfefs around prototype of netlbl_sk_lock_check() (thanks Paul Moore)
>
> v4:
>  - fix build when CONFIG_LOCKDEP is unset (thanks kernel test robot)
>
> v3:
>  - rename variable to 'sk_locked' (thanks Paul Moore)
>  - keep rcu_replace_pointer() open-coded and re-add NULL check of 'old',
>    these two changes will be posted in another patch (thanks Paul Moore)
>
> v2:
>  - pass lockdep_sock_is_held() through a boolean variable in the stack
>    (thanks Eric Dumazet, Paul Moore, Casey Schaufler)
>  - use rcu_replace_pointer() instead of rcu_dereference_protected() +
>    rcu_assign_pointer()
>  - remove NULL check of 'old' before kfree_rcu()
>
> Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> Reported-by: Xiumei Mu <xmu@redhat.com>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/net/cipso_ipv4.h     |  6 ++++--
>  include/net/netlabel.h       | 12 ++++++++++--
>  net/ipv4/cipso_ipv4.c        |  7 ++++---
>  net/netlabel/netlabel_kapi.c | 31 ++++++++++++++++++++++++++++---
>  security/selinux/netlabel.c  |  5 ++++-
>  security/smack/smack_lsm.c   |  3 ++-
>  6 files changed, 52 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/cipso_ipv4.h b/include/net/cipso_ipv4.h
> index 53dd7d988a2d..c9111bb2f59b 100644
> --- a/include/net/cipso_ipv4.h
> +++ b/include/net/cipso_ipv4.h
> @@ -183,7 +183,8 @@ int cipso_v4_getattr(const unsigned char *cipso,
>  		     struct netlbl_lsm_secattr *secattr);
>  int cipso_v4_sock_setattr(struct sock *sk,
>  			  const struct cipso_v4_doi *doi_def,
> -			  const struct netlbl_lsm_secattr *secattr);
> +			  const struct netlbl_lsm_secattr *secattr,
> +			  bool sk_locked);
>  void cipso_v4_sock_delattr(struct sock *sk);
>  int cipso_v4_sock_getattr(struct sock *sk, struct netlbl_lsm_secattr *secattr);
>  int cipso_v4_req_setattr(struct request_sock *req,
> @@ -214,7 +215,8 @@ static inline int cipso_v4_getattr(const unsigned char *cipso,
>  
>  static inline int cipso_v4_sock_setattr(struct sock *sk,
>  				      const struct cipso_v4_doi *doi_def,
> -				      const struct netlbl_lsm_secattr *secattr)
> +				      const struct netlbl_lsm_secattr *secattr,
> +				      bool sk_locked)
>  {
>  	return -ENOSYS;
>  }
> diff --git a/include/net/netlabel.h b/include/net/netlabel.h
> index f3ab0b8a4b18..2133ad723fc1 100644
> --- a/include/net/netlabel.h
> +++ b/include/net/netlabel.h
> @@ -470,7 +470,8 @@ void netlbl_bitmap_setbit(unsigned char *bitmap, u32 bit, u8 state);
>  int netlbl_enabled(void);
>  int netlbl_sock_setattr(struct sock *sk,
>  			u16 family,
> -			const struct netlbl_lsm_secattr *secattr);
> +			const struct netlbl_lsm_secattr *secattr,
> +			bool sk_locked);
>  void netlbl_sock_delattr(struct sock *sk);
>  int netlbl_sock_getattr(struct sock *sk,
>  			struct netlbl_lsm_secattr *secattr);
> @@ -487,6 +488,7 @@ int netlbl_skbuff_getattr(const struct sk_buff *skb,
>  			  u16 family,
>  			  struct netlbl_lsm_secattr *secattr);
>  void netlbl_skbuff_err(struct sk_buff *skb, u16 family, int error, int gateway);
> +bool netlbl_sk_lock_check(struct sock *sk);
>  
>  /*
>   * LSM label mapping cache operations
> @@ -614,7 +616,8 @@ static inline int netlbl_enabled(void)
>  }
>  static inline int netlbl_sock_setattr(struct sock *sk,
>  				      u16 family,
> -				      const struct netlbl_lsm_secattr *secattr)
> +				      const struct netlbl_lsm_secattr *secattr,
> +				      bool sk_locked)
>  {
>  	return -ENOSYS;
>  }
> @@ -673,6 +676,11 @@ static inline struct audit_buffer *netlbl_audit_start(int type,
>  {
>  	return NULL;
>  }
> +
> +static inline bool netlbl_sk_lock_check(struct sock *sk)
> +{
> +	return true;
> +}
>  #endif /* CONFIG_NETLABEL */
>  
>  const struct netlbl_calipso_ops *
> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 8b17d83e5fde..dd6d46015058 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -1815,6 +1815,7 @@ static int cipso_v4_genopt(unsigned char *buf, u32 buf_len,
>   * @sk: the socket
>   * @doi_def: the CIPSO DOI to use
>   * @secattr: the specific security attributes of the socket
> + * @sk_locked: true if caller holds the socket lock
>   *
>   * Description:
>   * Set the CIPSO option on the given socket using the DOI definition and
> @@ -1826,7 +1827,8 @@ static int cipso_v4_genopt(unsigned char *buf, u32 buf_len,
>   */
>  int cipso_v4_sock_setattr(struct sock *sk,
>  			  const struct cipso_v4_doi *doi_def,
> -			  const struct netlbl_lsm_secattr *secattr)
> +			  const struct netlbl_lsm_secattr *secattr,
> +			  bool sk_locked)
>  {
>  	int ret_val = -EPERM;
>  	unsigned char *buf = NULL;
> @@ -1876,8 +1878,7 @@ int cipso_v4_sock_setattr(struct sock *sk,
>  
>  	sk_inet = inet_sk(sk);
>  
> -	old = rcu_dereference_protected(sk_inet->inet_opt,
> -					lockdep_sock_is_held(sk));
> +	old = rcu_dereference_protected(sk_inet->inet_opt, sk_locked);
>  	if (inet_test_bit(IS_ICSK, sk)) {
>  		sk_conn = inet_csk(sk);
>  		if (old)
> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index 1ba4f58e1d35..cd9160bbc919 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -965,6 +965,7 @@ int netlbl_enabled(void)
>   * @sk: the socket to label
>   * @family: protocol family
>   * @secattr: the security attributes
> + * @sk_locked: true if caller holds the socket lock
>   *
>   * Description:
>   * Attach the correct label to the given socket using the security attributes
> @@ -977,7 +978,8 @@ int netlbl_enabled(void)
>   */
>  int netlbl_sock_setattr(struct sock *sk,
>  			u16 family,
> -			const struct netlbl_lsm_secattr *secattr)
> +			const struct netlbl_lsm_secattr *secattr,
> +			bool sk_locked)
>  {
>  	int ret_val;
>  	struct netlbl_dom_map *dom_entry;
> @@ -997,7 +999,7 @@ int netlbl_sock_setattr(struct sock *sk,
>  		case NETLBL_NLTYPE_CIPSOV4:
>  			ret_val = cipso_v4_sock_setattr(sk,
>  							dom_entry->def.cipso,
> -							secattr);
> +							secattr, sk_locked);
>  			break;
>  		case NETLBL_NLTYPE_UNLABELED:
>  			ret_val = 0;
> @@ -1090,6 +1092,28 @@ int netlbl_sock_getattr(struct sock *sk,
>  	return ret_val;
>  }
>  
> +/**
> + * netlbl_sk_lock_check - Check if the socket lock has been acquired.
> + * @sk: the socket to be checked
> + *
> + * Return: true if socket @sk is locked or if lock debugging is disabled at
> + * runtime or compile-time; false otherwise
> + *
> + */
> +#ifdef CONFIG_LOCKDEP
> +bool netlbl_sk_lock_check(struct sock *sk)
> +{
> +	if (debug_locks)
> +		return lockdep_sock_is_held(sk);
> +	return true;
> +}
> +#else
> +bool netlbl_sk_lock_check(struct sock *sk)
> +{
> +	return true;
> +}
> +#endif
> +
>  /**
>   * netlbl_conn_setattr - Label a connected socket using the correct protocol
>   * @sk: the socket to label
> @@ -1126,7 +1150,8 @@ int netlbl_conn_setattr(struct sock *sk,
>  		switch (entry->type) {
>  		case NETLBL_NLTYPE_CIPSOV4:
>  			ret_val = cipso_v4_sock_setattr(sk,
> -							entry->cipso, secattr);
> +							entry->cipso, secattr,
> +							netlbl_sk_lock_check(sk));
>  			break;
>  		case NETLBL_NLTYPE_UNLABELED:
>  			/* just delete the protocols we support for right now
> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index 8f182800e412..55885634e880 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -402,7 +402,10 @@ int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
>  	secattr = selinux_netlbl_sock_genattr(sk);
>  	if (secattr == NULL)
>  		return -ENOMEM;
> -	rc = netlbl_sock_setattr(sk, family, secattr);
> +	/* On socket creation, replacement of IP options is safe even if
> +	 * the caller does not hold the socket lock.
> +	 */
> +	rc = netlbl_sock_setattr(sk, family, secattr, true);
>  	switch (rc) {
>  	case 0:
>  		sksec->nlbl_state = NLBL_LABELED;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 146667937811..efeac8365ad0 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -2565,7 +2565,8 @@ static int smack_netlbl_add(struct sock *sk)
>  	local_bh_disable();
>  	bh_lock_sock_nested(sk);
>  
> -	rc = netlbl_sock_setattr(sk, sk->sk_family, &skp->smk_netlabel);
> +	rc = netlbl_sock_setattr(sk, sk->sk_family, &skp->smk_netlabel,
> +				 netlbl_sk_lock_check(sk));
>  	switch (rc) {
>  	case 0:
>  		ssp->smk_state = SMK_NETLBL_LABELED;

