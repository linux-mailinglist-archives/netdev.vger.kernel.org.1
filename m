Return-Path: <netdev+bounces-280424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NTxFPzL6GklQQIAu9opvQ
	(envelope-from <netdev+bounces-280424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:24:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2301446AC1
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34BCB302C5EC
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 13:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECF23E0253;
	Wed, 22 Apr 2026 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Y7/ELOLK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A09117BA2
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863863; cv=none; b=JGPIRXtCafib8uLISrpI0koJLMi3IKpUaKsRDqiIl96ky5e2Qppq4z+IYaKSu/AQ5EeiEq3aodRF1N8C9kDvh6wWVO8klM4n9YgmX5NhmYLelXghVZUpOSRMq6TReG8NOiPXeUF5yfzWObOYcfSGrENtiL4PgJ3q39hPAJx904Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863863; c=relaxed/simple;
	bh=4GxuuyMSlQ6NLADvS5Z35ENS8872BjLa9uyc5U0J7N0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R99CWC4TPnNunEK4XS3LT61gfgMjhwVq9EDVUk6z/9/rPRUri4HnmdrKWEsIWj3uk1AtxFsvuB6hG16AQ4ZpM01QJlpSbGUXrXBbmOxZmKcZH5/XzqWr4N2GLz6YexO+PxlL3Ya7KsWnuykGD9L7gIX5fsHjWz5MrIrRa2XvK1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Y7/ELOLK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso31900565e9.2
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 06:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1776863860; x=1777468660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5JlgsJdPL7wtu5Mt7X6K/pCay7xHXG85EOpMzec21jg=;
        b=Y7/ELOLKnoTe2wwHbCwpojhW6wz4lD68qmQPn3TjWeFQPJxnOgOcuNSGM/doVPhAIS
         Yb0uv1QjTjDnyVBd294lVFHNBjpj/H7kgwQyIGFBsRjbhYJnRbT8QvwLv4hg/T9u/HeA
         YTFNj3rdfn+Yiqn1KKm2farh527kYj/rKED28Z9rkcrahE5j3WpBgJOKw7liqeoVJW42
         aPrPFgXXnMi7Po53c+ZN3cksKBP71WGUwyH9dpQaaBYQEkHhhOYlyRB+LjJrDXbQFdV4
         2ajdEKkNWks6yLEM+jRU+tETirV6s6COXVInsDSH2WmG7lgRxueSCkmKTVwFxT+qrd5o
         7CZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776863860; x=1777468660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JlgsJdPL7wtu5Mt7X6K/pCay7xHXG85EOpMzec21jg=;
        b=bFfY4tN6O1AhC22QS9xtMubbvZt1D0jgMobDC55/Z13UqQ2kY99lmlJ01TbaU80gbr
         MBSSHtfUCnPXIMI1SNWioZ8Cne9lCyW7MeldwvjjLQ9hYamHQ6gvCajTWpE2MM6mL2Gq
         vNuAKMqfgJJKTb5OeX/XnYhLaNwq21MqPes+r9A4XxQvMx5K0UWyoq76ChUM/Bys6O+d
         7A6CUvXe/z66TMQJMYNErAc7ZAau/tibV/+GgtWA73g1xmeNaNcRFN+h4p1/Sz0RGY3G
         Pwp3BgXip5sE52njZE28C0xen3XkaQ+o7azFHOHnu5YZnyek6TTprBfBQT5ib4rK9T42
         JDEA==
X-Gm-Message-State: AOJu0YythW3Zks9j7PyybAqMxQvBeRSoDZj6e5sovd2AkTtNJmqYwTI6
	2siiWxfIBTzXwo5k/ekdUwrlwZ1tbKymAT1fJrbrEBgiz1qnXeqIkiOof/9SCIGjtD0=
X-Gm-Gg: AeBDiesk+KBpiUVJZ2NqEhEI7nA4OM9zqAy2tvuUFvD4SCuZkT9urOLhSdFIkn322jD
	oZhthpoKaIvFtZ6G7Pw6/MR+Tpmqrmmd2EOhi0wPGz5wipK5vbxtPVq6O4nu7UvDaztxRLfbXy4
	rXDUao1vvfHjeIOBYvPKyFHAsJfv82YOo68QlMvCJncpW9sjAPNMBqgtNYGtqBitIntwwNSzPXh
	Q6AlPRRD8vv6Xt8Y9WOChD1Am8Npy5L6Yaqy3GlJUrfrj1ChUTKi43DtGBWKgNUf8RSM0Eu+5uz
	BeZ4vNPt/aV6obxz00+OYiQ9BE2ZlC1UUvY4859vgHT0P3+OOmpc39bmnGipXmm7w71suuJqcHA
	vBrWozb22rSL6swuuZJPwVY6ZK2oPyyMRW6XhujXM1v6JLCUdQSxGG0/ergDZ0sP0qeoPZ7c5PK
	Ixs3znc22zvQ8mUEkZIKo2IW7BNhgQ2mGjjSHfekf4N7q3vKFtbEMqippJa0mM2B8J
X-Received: by 2002:a05:600c:890c:b0:485:3ff1:d5ed with SMTP id 5b1f17b1804b1-488fb739cd9mr265621335e9.1.1776863859192;
        Wed, 22 Apr 2026 06:17:39 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d6casm41495844f8f.32.2026.04.22.06.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 06:17:38 -0700 (PDT)
Message-ID: <46196178-51e0-4744-9154-bbad895568d6@blackwall.org>
Date: Wed, 22 Apr 2026 16:17:36 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-deletions v2] net: remove unused ATM protocols and
 legacy ATM device drivers
Content-Language: en-US, bg
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, linux@armlinux.org.uk, tsbogend@alpha.franken.de,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, 3chas3@gmail.com, idosch@nvidia.com,
 jani.nikula@intel.com, mchehab+huawei@kernel.org, tytso@mit.edu,
 herbert@gondor.apana.org.au, geert@linux-m68k.org, ebiggers@kernel.org,
 johannes.berg@intel.com, jonathan.cameron@huawei.com, kees@kernel.org,
 kuniyu@google.com, fourier.thomas@gmail.com, andriy.shevchenko@intel.com,
 rdunlap@infradead.org, akpm@linux-foundation.org, linux-doc@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bridge@lists.linux.dev, dwmw2@infradead.org
References: <20260422041846.2035118-1-kuba@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260422041846.2035118-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,linuxfoundation.org,armlinux.org.uk,alpha.franken.de,linux.ibm.com,ellerman.id.au,gmail.com,nvidia.com,intel.com,mit.edu,gondor.apana.org.au,linux-m68k.org,huawei.com,infradead.org,linux-foundation.org,lists.ozlabs.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[blackwall.org];
	TAGGED_FROM(0.00)[bounces-280424-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:server fail];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2301446AC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 22/04/2026 07:18, Jakub Kicinski wrote:
> Remove the ATM protocol modules and PCI/SBUS ATM device drivers
> that are no longer in active use.
> 
> The ATM core protocol stack, PPPoATM, BR2684, and USB DSL modem
> drivers (drivers/usb/atm/) are retained in-tree to maintain PPP
> over ATM (PPPoA) and PPPoE-over-BR2684 support for DSL connections.
> 
> Removed ATM protocol modules:
>   - net/atm/clip.c - Classical IP over ATM (RFC 2225)
>   - net/atm/lec.c - LAN Emulation Client (LANE)
>   - net/atm/mpc.c, mpoa_caches.c, mpoa_proc.c - Multi-Protocol Over ATM
> 
> Removed PCI/SBUS ATM device drivers (drivers/atm/):
>   - adummy, atmtcp - software/testing ATM devices
>   - eni - Efficient Networks ENI155P (OC-3, ~1995)
>   - fore200e - FORE Systems 200E PCI/SBUS (OC-3, ~1999)
>   - he - ForeRunner HE (OC-3/OC-12, ~2000)
>   - idt77105 - IDT 77105 25 Mbps ATM PHY
>   - idt77252 - IDT 77252 NICStAR II (OC-3, ~2000)
>   - iphase - Interphase ATM PCI (OC-3/DS3/E3)
>   - lanai - Efficient Networks Speedstream 3010
>   - nicstar - IDT 77201 NICStAR (155/25 Mbps, ~1999)
>   - solos-pci - Traverse Technologies ADSL2+ PCI
>   - suni - PMC S/UNI SONET PHY library
> 
> Also clean up references in:
>   - net/bridge/ - remove ATM LANE hook (br_fdb_test_addr_hook,
>     br_fdb_test_addr)
>   - net/core/dev.c - remove br_fdb_test_addr_hook export
>   - defconfig files - remove ATM driver config options
> 
> The removed code is moved to an out-of-tree module package (mod-orphan).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>   - keep BR2684
>   - correct the claim that Traverse Technologies is defunct,
>     I'm still deleting the solos driver, chances are nobody uses it.
>     Easy enough to revert back in since core is still around.
>     The guiding principle is to keep USB modems and delete
>     the rest as USB ADSL2+ CPEs were most popular historically.
> v1: https://lore.kernel.org/20260421021943.1295109-1-kuba@kernel.org
> 
> CC: corbet@lwn.net
> CC: skhan@linuxfoundation.org
> CC: linux@armlinux.org.uk
> CC: tsbogend@alpha.franken.de
> CC: maddy@linux.ibm.com
> CC: mpe@ellerman.id.au
> CC: npiggin@gmail.com
> CC: chleroy@kernel.org
> CC: 3chas3@gmail.com
> CC: razor@blackwall.org
> CC: idosch@nvidia.com
> CC: jani.nikula@intel.com
> CC: mchehab+huawei@kernel.org
> CC: tytso@mit.edu
> CC: herbert@gondor.apana.org.au
> CC: geert@linux-m68k.org
> CC: ebiggers@kernel.org
> CC: johannes.berg@intel.com
> CC: jonathan.cameron@huawei.com
> CC: kees@kernel.org
> CC: kuniyu@google.com
> CC: fourier.thomas@gmail.com
> CC: andriy.shevchenko@intel.com
> CC: rdunlap@infradead.org
> CC: akpm@linux-foundation.org
> CC: linux-doc@vger.kernel.org
> CC: linux-mips@vger.kernel.org
> CC: linuxppc-dev@lists.ozlabs.org
> CC: bridge@lists.linux.dev
> CC: dwmw2@infradead.org
> CC: herbert@gondor.apana.org.au
> ---
>   MAINTAINERS                                   |    3 +-
>   Documentation/.renames.txt                    |    2 -
>   .../device_drivers/atm/fore200e.rst           |   66 -
>   .../networking/device_drivers/atm/index.rst   |    2 -
>   .../networking/device_drivers/atm/iphase.rst  |  193 -
>   drivers/atm/Kconfig                           |  325 --
>   drivers/net/Kconfig                           |    2 -
>   net/atm/Kconfig                               |   37 -
>   drivers/Makefile                              |    1 -
>   drivers/atm/Makefile                          |   32 -
>   net/atm/Makefile                              |    4 -
>   drivers/atm/eni.h                             |  136 -
>   drivers/atm/fore200e.h                        |  973 -----
>   drivers/atm/he.h                              |  845 ----
>   drivers/atm/idt77105.h                        |   92 -
>   drivers/atm/idt77252.h                        |  816 ----
>   drivers/atm/idt77252_tables.h                 |  781 ----
>   drivers/atm/iphase.h                          | 1452 -------
>   drivers/atm/midway.h                          |  266 --
>   drivers/atm/nicstar.h                         |  759 ----
>   drivers/atm/suni.h                            |  242 --
>   drivers/atm/tonga.h                           |   21 -
>   drivers/atm/zeprom.h                          |   35 -
>   net/atm/lec.h                                 |  155 -
>   net/atm/lec_arpc.h                            |   97 -
>   net/atm/mpc.h                                 |   65 -
>   net/atm/mpoa_caches.h                         |   99 -
>   net/bridge/br_private.h                       |    4 -
>   drivers/atm/adummy.c                          |  202 -
>   drivers/atm/atmtcp.c                          |  513 ---
>   drivers/atm/eni.c                             | 2321 ----------
>   drivers/atm/fore200e.c                        | 3012 -------------
>   drivers/atm/he.c                              | 2861 -------------
>   drivers/atm/idt77105.c                        |  376 --
>   drivers/atm/idt77252.c                        | 3797 -----------------
>   drivers/atm/iphase.c                          | 3283 --------------
>   drivers/atm/lanai.c                           | 2603 -----------
>   drivers/atm/nicstar.c                         | 2759 ------------
>   drivers/atm/nicstarmac.c                      |  244 --
>   drivers/atm/solos-attrlist.c                  |   83 -
>   drivers/atm/solos-pci.c                       | 1496 -------
>   drivers/atm/suni.c                            |  391 --
>   net/atm/clip.c                                |  960 -----
>   net/atm/lec.c                                 | 2274 ----------
>   net/atm/mpc.c                                 | 1538 -------
>   net/atm/mpoa_caches.c                         |  565 ---
>   net/atm/mpoa_proc.c                           |  307 --
>   net/bridge/br.c                               |    7 -
>   net/bridge/br_fdb.c                           |   29 -
>   net/core/dev.c                                |    7 -
>   arch/arm/configs/ixp4xx_defconfig             |    5 -
>   arch/mips/configs/gpr_defconfig               |   13 -
>   arch/mips/configs/mtx1_defconfig              |   13 -
>   arch/powerpc/configs/ppc6xx_defconfig         |    9 -
>   drivers/atm/.gitignore                        |    5 -
>   drivers/atm/nicstarmac.copyright              |   61 -
>   56 files changed, 2 insertions(+), 37237 deletions(-)
>   delete mode 100644 Documentation/networking/device_drivers/atm/fore200e.rst
>   delete mode 100644 Documentation/networking/device_drivers/atm/iphase.rst
>   delete mode 100644 drivers/atm/Kconfig
>   delete mode 100644 drivers/atm/Makefile
>   delete mode 100644 drivers/atm/eni.h
>   delete mode 100644 drivers/atm/fore200e.h
>   delete mode 100644 drivers/atm/he.h
>   delete mode 100644 drivers/atm/idt77105.h
>   delete mode 100644 drivers/atm/idt77252.h
>   delete mode 100644 drivers/atm/idt77252_tables.h
>   delete mode 100644 drivers/atm/iphase.h
>   delete mode 100644 drivers/atm/midway.h
>   delete mode 100644 drivers/atm/nicstar.h
>   delete mode 100644 drivers/atm/suni.h
>   delete mode 100644 drivers/atm/tonga.h
>   delete mode 100644 drivers/atm/zeprom.h
>   delete mode 100644 net/atm/lec.h
>   delete mode 100644 net/atm/lec_arpc.h
>   delete mode 100644 net/atm/mpc.h
>   delete mode 100644 net/atm/mpoa_caches.h
>   delete mode 100644 drivers/atm/adummy.c
>   delete mode 100644 drivers/atm/atmtcp.c
>   delete mode 100644 drivers/atm/eni.c
>   delete mode 100644 drivers/atm/fore200e.c
>   delete mode 100644 drivers/atm/he.c
>   delete mode 100644 drivers/atm/idt77105.c
>   delete mode 100644 drivers/atm/idt77252.c
>   delete mode 100644 drivers/atm/iphase.c
>   delete mode 100644 drivers/atm/lanai.c
>   delete mode 100644 drivers/atm/nicstar.c
>   delete mode 100644 drivers/atm/nicstarmac.c
>   delete mode 100644 drivers/atm/solos-attrlist.c
>   delete mode 100644 drivers/atm/solos-pci.c
>   delete mode 100644 drivers/atm/suni.c
>   delete mode 100644 net/atm/clip.c
>   delete mode 100644 net/atm/lec.c
>   delete mode 100644 net/atm/mpc.c
>   delete mode 100644 net/atm/mpoa_caches.c
>   delete mode 100644 net/atm/mpoa_proc.c
>   delete mode 100644 drivers/atm/.gitignore
>   delete mode 100644 drivers/atm/nicstarmac.copyright
> 

FWIW,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



