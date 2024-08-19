Return-Path: <netdev+bounces-119648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAF39567AE
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00591C21992
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2686F15D5C8;
	Mon, 19 Aug 2024 09:56:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1605A13B592;
	Mon, 19 Aug 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061363; cv=none; b=imQu2Pe11TlkTFNfb8SlxnXj4BIvq0BwypwpHuZCzI66QypDcdqKMcBdrKoYxXFwTxRc/atVPv4aki5Nb/bj69bKH92+qdajnywEwmN2Ie89eB8kaAzJ3dFRI4AScP2usN7XQWberrzXUyyVoqwN839Py6PYIsW2GwEWsJOeXdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061363; c=relaxed/simple;
	bh=VLYWVf8Qcozvi40haKA48f4D8Us26/7fazabDmV6LZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g07ZrsqdJsfgRmup30hYDbqYL2p2bdK+l86GkFsJdZkXVOZ95zVGnfF0B0PVE9wgyedEN9gkPFoFNgrlUwXRKxRmJT+0kHI+U4o5Y9VJE1YHRjOptYjTIZnbnUD2yU9DmhgxlcEcfu3QGZ6j4OeP8X3hSNwTfCyGcW5JZkTiJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42809d6e719so34416485e9.3;
        Mon, 19 Aug 2024 02:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724061359; x=1724666159;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Veq1wWeqRSupb5kRiwYWaZTabvOBgn7lNC6druhFlP8=;
        b=njllHc6w6cTWZkhy+BqsP2IHoUcj7V9M+1wmv1RX0dEgQfmY76xhqPWWa+xrK2Arfg
         Zyk79cO+WPfIrrSiQ3Z+NIVt5Qszr5hWsVuJu8vQCJVEpu6Ox/ugloCLtHNdum8rYsXT
         B4mRQPD0JMYYdYJw8WI8AWw5OA+zrbdT/5Iz89NO8zAQSNaBsqXhm0zIe45QNY9eu5N+
         sHw6/ggi4DgYhgEzSbQnccb+Rp5vs4ykWPhoLG/dvef9fm0/xy8chTw0/lPIJ3O6QYJv
         MqhfDQD3tExm246EwrAC5P6WoWTDJoMI4Tj+RpSwQzwdaC/zZs1e90gLNVWqvxVQSrDw
         mlwA==
X-Forwarded-Encrypted: i=1; AJvYcCUH8UL+MGRgXha9gJT9x5JxHbj9Xn+r+JAYTVmEGs+h5MCiEIU4C67VHouS2ceVyg5kYg6blqFrO7WVgwrWxJd8gHQYXpSCx5FU8r/ziyOC4UVGLTVKonpFTI3Z+IHBDLCr8XKhWpMVxx73CUSIQWCyPlu0LSR54We//ScGkQ4BWYeF/COa
X-Gm-Message-State: AOJu0YzUK8VlI+WWxKNFP7XEwt0WG3zEQdc3ncITEaNIljR+2TAGYP/c
	wWGgTJ8IuJsKCc6ZrGCVpbUmDkEbpGmXjOg3ylIvjG6EBYYhqM2m
X-Google-Smtp-Source: AGHT+IFOyRJArVq9+yPKGCf2fhYHM2d42YnOKeBDiG+jry2n9yN8arxjJfYEx+QQbeHh4A3XbcTx5g==
X-Received: by 2002:adf:e88e:0:b0:36b:d21e:bf85 with SMTP id ffacd0b85a97d-371a7477a4bmr4186792f8f.51.1724061358742;
        Mon, 19 Aug 2024 02:55:58 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aac62sm10023915f8f.101.2024.08.19.02.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 02:55:58 -0700 (PDT)
Message-ID: <74e86f5b-ee2e-4093-ab38-41cc52039601@kernel.org>
Date: Mon, 19 Aug 2024 11:55:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] appletalk: tashtalk: Add LocalTalk line
 discipline driver for AppleTalk using a TashTalk adapter
To: Rodolfo Zitellini <rwz@xhero.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Doug Brown <doug@schmorgal.com>
References: <20240817093316.9239-1-rwz@xhero.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240817093316.9239-1-rwz@xhero.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17. 08. 24, 11:33, Rodolfo Zitellini wrote:
> --- /dev/null
> +++ b/drivers/net/appletalk/tashtalk.c
> @@ -0,0 +1,1003 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*      tashtalk.c: TashTalk LocalTalk driver for Linux.
> + *
> + *	Authors:
> + *      Rodolfo Zitellini (twelvetone12)
> + *
> + *      Derived from:
> + *      - slip.c: A network driver outline for linux.
> + *        written by Laurence Culhane and Fred N. van Kempen
> + *
> + *      This software may be used and distributed according to the terms
> + *      of the GNU General Public License, incorporated herein by reference.
> + *
> + */
> +
> +#include <linux/compat.h>

What is this used for?

> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/version.h>
> +
> +#include <linux/uaccess.h>
> +#include <linux/bitops.h>
> +#include <linux/sched/signal.h>
> +#include <linux/string.h>
> +#include <linux/mm.h>
> +#include <linux/interrupt.h>
> +#include <linux/in.h>
> +#include <linux/tty.h>
> +#include <linux/errno.h>
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +#include <linux/skbuff.h>
> +#include <linux/rtnetlink.h>
> +#include <linux/if_arp.h>
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
> +#include <linux/if_ltalk.h>
> +#include <linux/atalk.h>

Are all those needed? I doubt that.

> +#ifndef TASH_DEBUG
> +#define TASH_DEBUG 0
> +#endif
> +static unsigned int tash_debug = TASH_DEBUG;

Can we use dyn dbg instead?

> +/* Max number of channels
> + * override with insmod -otash_maxdev=nnn
> + */
> +#define TASH_MAX_CHAN 32
> +#define TT_MTU 605
> +/* The buffer should be double since potentially
> + * all bytes inside are escaped.
> + */
> +#define BUF_LEN (TT_MTU * 2 + 4)
> +
> +struct tashtalk {
> +	int magic;

Where did you dig this driver from? Drop this.

> +	struct tty_struct *tty;        /* ptr to TTY structure		*/
> +	struct net_device *dev;        /* easy for intr handling	*/
> +	spinlock_t lock;
> +	wait_queue_head_t addr_wait;
> +	struct work_struct tx_work;    /* Flushes transmit buffer	*/
> +
> +	/* These are pointers to the malloc()ed frame buffers. */
> +	unsigned char *rbuff;          /* receiver buffer		*/
> +	int rcount;                    /* received chars counter       */

uint?

> +	unsigned char *xbuff;          /* transmitter buffer		*/
> +	unsigned char *xhead;          /* pointer to next byte to XMIT */

Switch to u8's.

> +	int xleft;                     /* bytes left in XMIT queue     */
> +	int mtu;
> +	int buffsize;                  /* Max buffers sizes            */

So uint?

> +	unsigned long flags;           /* Flag values/ mode etc	*/
> +	unsigned char mode;            /* really not used */
> +	pid_t pid;

Storing pid is usually wrong. So is here.

Many of the above is ancient material.

> +	struct atalk_addr node_addr;   /* Full node address */
> +};
...
> +static void tash_setbits(struct tashtalk *tt, unsigned char addr)
> +{
> +	unsigned char bits[33];

u8

> +	unsigned int byte, pos;
> +
> +	/* 0, 255 and anything else are invalid */
> +	if (addr == 0 || addr >= 255)
> +		return;
> +
> +	memset(bits, 0, sizeof(bits));
> +
> +	/* in theory we can respond to many addresses */
> +	byte = addr / 8 + 1; /* skip initial command byte */
> +	pos = (addr % 8);
> +
> +	if (tash_debug)
> +		netdev_dbg(tt->dev,
> +			   "Setting address %i (byte %i bit %i) for you.",
> +			    addr, byte - 1, pos);
> +
> +	bits[0] = TT_CMD_SET_NIDS;
> +	bits[byte] = (1 << pos);

BIT()

> +
> +	set_bit(TTY_DO_WRITE_WAKEUP, &tt->tty->flags);
> +	tt->tty->ops->write(tt->tty, bits, sizeof(bits));
> +}
> +
> +static u16 tt_crc_ccitt_update(u16 crc, u8 data)
> +{
> +	data ^= (u8)(crc) & (u8)(0xFF);
> +	data ^= data << 4;
> +	return ((((u16)data << 8) | ((crc & 0xFF00) >> 8)) ^ (u8)(data >> 4) ^
> +		((u16)data << 3));

Is this real ccitt? Won't crc_ccitt_byte() work then?

> +}
> +
> +static u16 tash_crc(const unsigned char *data, int len)
> +{
> +	u16 crc = 0xFFFF;
> +
> +	for (int i = 0; i < len; i++)
> +		crc = tt_crc_ccitt_update(crc, data[i]);
> +
> +	return crc;

Or even crc_ccitt()?

> +}
...
> +/* Write out any remaining transmit buffer. Scheduled when tty is writable */
> +static void tash_transmit_worker(struct work_struct *work)
> +{
> +	struct tashtalk *tt = container_of(work, struct tashtalk, tx_work);
> +	int actual;
> +
> +	spin_lock_bh(&tt->lock);
> +	/* First make sure we're connected. */
> +	if (!tt->tty || tt->magic != TASH_MAGIC || !netif_running(tt->dev)) {

Can the former two happen?

> +		spin_unlock_bh(&tt->lock);
> +		return;
> +	}
> +
> +	/* We always get here after all transmissions
> +	 * No more data?
> +	 */
> +	if (tt->xleft <= 0) {
> +		/* reset the flags for transmission
> +		 * and re-wake the netif queue
> +		 */
> +		tt->dev->stats.tx_packets++;
> +		clear_bit(TTY_DO_WRITE_WAKEUP, &tt->tty->flags);
> +		spin_unlock_bh(&tt->lock);
> +		netif_wake_queue(tt->dev);
> +
> +		return;
> +	}
> +
> +	/* Send whatever is there to send
> +	 * This function will be called again if xleft <= 0
> +	 */
> +	actual = tt->tty->ops->write(tt->tty, tt->xhead, tt->xleft);

returns ssize_t

> +	tt->xleft -= actual;
> +	tt->xhead += actual;
> +
> +	spin_unlock_bh(&tt->lock);
> +}
> +
> +/* Called by the driver when there's room for more data.
> + * Schedule the transmit.

Is this a valid multiline comment in net/?

> + */
...

> +static void tt_tx_timeout(struct net_device *dev, unsigned int txqueue)
> +{
> +	struct tashtalk *tt = netdev_priv(dev);
> +
> +	spin_lock(&tt->lock);

guard()?

> +
> +	if (netif_queue_stopped(dev)) {
> +		if (!netif_running(dev) || !tt->tty)
> +			goto out;
> +	}
> +out:
> +	spin_unlock(&tt->lock);
> +}
...
> +/* Netdevice DOWN -> UP routine */
> +
> +static int tt_open(struct net_device *dev)
> +{
> +	struct tashtalk *tt = netdev_priv(dev);
> +
> +	if (!tt->tty) {

No lock?

> +		netdev_err(dev, "TTY not open");
> +		return -ENODEV;
> +	}
> +
> +	tt->flags &= (1 << TT_FLAG_INUSE);

so clear_bit()?

> +	netif_start_queue(dev);
> +	return 0;
> +}

> +static void tashtalk_send_ctrl_packet(struct tashtalk *tt, unsigned char dst,
> +				      unsigned char src, unsigned char type)
> +{
> +	unsigned char cmd = TT_CMD_TX;
> +	unsigned char buf[5];

u8

> +	int actual;
> +	u16 crc;
> +
> +	buf[LLAP_DST_POS] = dst;
> +	buf[LLAP_SRC_POS] = src;
> +	buf[LLAP_TYP_POS] = type;
> +
> +	crc = tash_crc(buf, 3);
> +	buf[3] = ~(crc & 0xFF);
> +	buf[4] = ~(crc >> 8);
> +
> +	actual = tt->tty->ops->write(tt->tty, &cmd, 1);
> +	actual += tt->tty->ops->write(tt->tty, buf, sizeof(buf));

What is actual used for? And why is this not a single write (using 
buf[6] instead).

> +}
...
> +static void tashtalk_receive_buf(struct tty_struct *tty,
> +				 const u8 *cp, const u8 *fp,
> +				 size_t count)
> +{
> +	struct tashtalk *tt = tty->disc_data;
> +	int i;
> +
> +	if (!tt || tt->magic != TASH_MAGIC || !netif_running(tt->dev))

How can that happen?

> +		return;
> +
> +	if (tash_debug)
> +		netdev_dbg(tt->dev, "(1) TashTalk read %li", count);
> +
> +	print_hex_dump_bytes("Tash read: ", DUMP_PREFIX_NONE, cp, count);
> +
> +	if (!test_bit(TT_FLAG_INFRAME, &tt->flags)) {
> +		tt->rcount = 0;
> +		if (tash_debug)
> +			netdev_dbg(tt->dev, "(2) TashTalk start new frame");
> +	} else if (tash_debug) {
> +		netdev_dbg(tt->dev, "(2) TashTalk continue frame");
> +	}
> +
> +	set_bit(TT_FLAG_INFRAME, &tt->flags);

So test_and_set_bit()?

> +
> +	for (i = 0; i < count; i++) {
> +		set_bit(TT_FLAG_INFRAME, &tt->flags);

Why again?

> +
> +		if (cp[i] == 0x00) {
> +			set_bit(TT_FLAG_ESCAPE, &tt->flags);
> +			continue;
> +		}
> +
> +		if (test_and_clear_bit(TT_FLAG_ESCAPE, &tt->flags)) {
> +			if (cp[i] == 0xFF) {
> +				tt->rbuff[tt->rcount] = 0x00;
> +				tt->rcount++;
> +			} else {
> +				tashtalk_manage_escape(tt, cp[i]);
> +			}
> +		} else {
> +			tt->rbuff[tt->rcount] = cp[i];
> +			tt->rcount++;
> +		}
> +	}
> +
> +	if (tash_debug)
> +		netdev_dbg(tt->dev, "(5) Done read, pending frame=%i",
> +			   test_bit(TT_FLAG_INFRAME, &tt->flags));
> +}
...

> +static void tashtalk_close(struct tty_struct *tty)
> +{
> +	struct tashtalk *tt = tty->disc_data;
> +
> +	/* First make sure we're connected. */
> +	if (!tt || tt->magic != TASH_MAGIC || tt->tty != tty)

How can these happen?

> +		return;
> +
> +	spin_lock_bh(&tt->lock);
> +	rcu_assign_pointer(tty->disc_data, NULL);
> +	tt->tty = NULL;
> +	spin_unlock_bh(&tt->lock);
> +
> +	synchronize_rcu();
> +	flush_work(&tt->tx_work);
> +
> +	/* Flush network side */
> +	unregister_netdev(tt->dev);
> +	/* This will complete via tt_free_netdev */
> +}
...
> +static int __init tashtalk_init(void)
> +{
> +	int status;
> +
> +	if (tash_maxdev < 1)
> +		tash_maxdev = 1;
> +
> +	pr_info("TashTalk Interface (dynamic channels, max=%d)",
> +		tash_maxdev);

No info messages, please.

> +	tashtalk_devs =
> +		kcalloc(tash_maxdev, sizeof(struct net_device *), GFP_KERNEL);
> +	if (!tashtalk_devs)
> +		return -ENOMEM;

Something more modern? Like idr or a list?

> +	/* Fill in our line protocol discipline, and register it */
> +	status = tty_register_ldisc(&tashtalk_ldisc);
> +	if (status != 0) {
> +		pr_err("TaskTalk: can't register line discipline (err = %d)\n",
> +		       status);
> +		kfree(tashtalk_devs);
> +	}
> +	return status;
> +}
> +
> +static void __exit tashtalk_exit(void)
> +{
> +	unsigned long timeout = jiffies + HZ;
> +	struct net_device *dev;
> +	struct tashtalk *tt;
> +	int busy = 0;
> +	int i;
> +
> +	if (!tashtalk_devs)
> +		return;
> +
> +	/* First of all: check for active disciplines and hangup them. */
> +	do {
> +		if (busy)
> +			msleep_interruptible(100);
> +
> +		busy = 0;
> +		for (i = 0; i < tash_maxdev; i++) {
> +			dev = tashtalk_devs[i];
> +			if (!dev)
> +				continue;
> +			tt = netdev_priv(dev);
> +			spin_lock_bh(&tt->lock);
> +			if (tt->tty) {
> +				busy++;
> +				tty_hangup(tt->tty);
> +			}
> +			spin_unlock_bh(&tt->lock);
> +		}
> +	} while (busy && time_before(jiffies, timeout));

Is this neeeded at all? You cannot unload the module while the ldisc is 
active, right? (Unlike NET, TTY increases module count.)

> +	for (i = 0; i < tash_maxdev; i++) {
> +		dev = tashtalk_devs[i];
> +		if (!dev)
> +			continue;
> +		tashtalk_devs[i] = NULL;
> +
> +		tt = netdev_priv(dev);
> +		if (tt->tty) {
> +			pr_err("%s: tty discipline still running\n",
> +			       dev->name);
> +		}
> +
> +		unregister_netdev(dev);

Those should be unregistered in tty ldisc closes, no?

> +	}
> +
> +	kfree(tashtalk_devs);
> +	tashtalk_devs = NULL;
> +
> +	tty_unregister_ldisc(&tashtalk_ldisc);
> +}

thanks,
-- 
js
suse labs


