Return-Path: <netdev+bounces-216403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43B3B3369F
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 08:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F77B3A6EAF
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BADD285061;
	Mon, 25 Aug 2025 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwU03Bsq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0704284682;
	Mon, 25 Aug 2025 06:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104262; cv=none; b=CP/ccAcWLXwPl3mlU2B6B268aVDK8kEXW1+pStqXGvo4UyqDL0D+v0mbNts92br5WRCwpzwfGESx3Dst8UaoJNNpERI8CRGwM7yf6t/kSSRkfXmX+vM2XsLNIqMNjf035IlolxQKNH8xXxkd42Qr/zyUP+dDaC9EuXcJL1kuyEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104262; c=relaxed/simple;
	bh=rTO/e4WqSOrdWPQgepcURVhkCV2WHwD7SKQGXk4GfOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtKaXrTVepXv9s4XxHOrV4NsmYa1BWK3EhsKyw3kIeelj2spoyCWjhqlouByftllFvJs1Yy5LP7OqCdVXdWZTtXB2VKz4+Um4QE6t2mGZelJCG6gaiIZI+OUhdeobs1ntQwK3aOv5smXyqF+vumNiD9j0eOkPPlPgnVlH8WSjJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwU03Bsq; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c79f0a606fso898193f8f.0;
        Sun, 24 Aug 2025 23:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104259; x=1756709059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8HWUNfO3LJWvbH9oGtE7hlgtUWNDAOxYh9Ccv/FTl8U=;
        b=TwU03Bsqo9Nd/+ZNKKChQYkfj7WMzFRfIbmySFs1BfSq9u0iVS0VQyh9zKOFHJypvc
         xIuIG/6Emad1T3+AOrCkYboDn2q/RvWQRMuaMJBvD5/3g9GIq/64fS7snjLZ6eKrS7gx
         1GY/66bLL8ZgKmQtomVS+Lumg4XvEnC7W3bv5tSMkjKEqzZHHIsD8uAZ8sxS0pX2t2fp
         re7oAKN9ndfizaK5OW4gRuKIkD6q3/Ph6iq3UkAq4LxClWAG1UT2XbO1dZPKS/kLKyOc
         VyqC8qyy1iWPdf89N0PTa4VO505GqTTt7jKozG+X3OXtmADau6ySZX45tJIb8aj1mAlf
         5CBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104259; x=1756709059;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HWUNfO3LJWvbH9oGtE7hlgtUWNDAOxYh9Ccv/FTl8U=;
        b=M+8xOh+PmKP1CjdNQcSwdNrC2UrORxAOb4qXQe+o0JjczpHNybh7VvICDR5/KDMDoC
         PCL7rt93+TwbCekk/OyVewzxXjnD+/eRy8bVmn1LfBVzCQ3eto+bpxyBRAY4QFyJJeZm
         0KotKc3qvmM3PFCFq8BxP1ncP4lfycXxR2ah6Ug1ugsUX/DAVuLoUcwbiftkm/mNaaRH
         lBhx25MhxsLZinHsx9Yug4W4pT3uOwm9PVdjdSnfZM+J+cYf80dfPAZXd51KGfdcEtFn
         +FtBeBjG50Q9/XJZd3qTlMoopzVTQ/61T1qNBVeLX+H5SSGcRpbVAmJ/mWIuFyE+lIA2
         7/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUCYw10uZ02eIrqW1PDfomgk0Fi1swCNlJPTHUxMIRGc67F4QJH50Yd0x6a7fYzC9lxqDV9lNy+QSRj79E=@vger.kernel.org, AJvYcCWiizHdPkOp6R4bFnL29LwCcCSh+TZx97FyVbFYktZ9LTKpriw96qDJXEeJvEOwzYF5Qtvg0plg@vger.kernel.org
X-Gm-Message-State: AOJu0YyayWW3W0NOKYyDr0W2EPkJhbrC0Vrkru/Dfc2xGpo0g3O+X3Km
	4TVXQbmdfZj7ai8tGAowlEaS3Uq1lm7FRFPA9Q8Cs6p4hCCCx2GIuhYj
X-Gm-Gg: ASbGnctAi/x7fzhGyNn2iP86yM0kf+EMk5li9bfx5f2XvcbfP0kbER19OrA7fvcEj8H
	uQezt4W9XrLxE+QM49rSZ9XrvkCw9wDWdW+K4Zkq+Ogz+X0JU2C3WyKsAy3Ge3Q+NsKtHnPExxj
	qyHAUflO6j06T9oxMr/CyKF+iIuiVpdQM/74/9uuJ9u3pPCSTYkMVziu/KJmrcbRc2NHP6Fn5xL
	9slNBXI5z3UCv2JVfMjk9avZf4xI1+lptk+6W3yEAU2y4TEXuf2TYWuEcs/UJO+0qRTKryJzDA9
	PKrQ9gHXlxEQiOyjMC6u6AXdd2ddBwdEde3U6qNfWa7oikIz8/1Apu0B9zqd8/mG4QvKA/0VXSQ
	f8FEnw0rVjZUgdfNgPa0APqCVFpcSJJtrlvCbMSl1Oo2yyr/bP4Pw+f+kqrdXQhDKbVNq2WNP7I
	XpHDQ4xa+XvB6ccPUeLRGyGexWxTKzHHKLM//17TgMUkNmsF4S6MfmZmj6eZce5kB1tDlNR9HO
X-Google-Smtp-Source: AGHT+IFLyNvckRMXdI3Nt+FFKkIq1zme4Hf1l2IQ/RdXV412x1+5JR4D+9iRogwGJpKljzpT/3Skfw==
X-Received: by 2002:a05:6000:188e:b0:3b8:d360:336f with SMTP id ffacd0b85a97d-3c5dc448b65mr8353903f8f.28.1756104258667;
        Sun, 24 Aug 2025 23:44:18 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f3e:d400:e93c:7fd0:412b:4a6b? (p200300ea8f3ed400e93c7fd0412b4a6b.dip0.t-ipconnect.de. [2003:ea:8f3e:d400:e93c:7fd0:412b:4a6b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3c70ef55bddsm9999664f8f.22.2025.08.24.23.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 23:44:18 -0700 (PDT)
Message-ID: <c6c354ec-e4fe-4b80-b2e5-9f6c8350b504@gmail.com>
Date: Mon, 25 Aug 2025 08:44:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] Fixes: xircom auto-negoation timer
To: Alex Tran <alex.t.tran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250825012821.492355-1-alex.t.tran@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
In-Reply-To: <20250825012821.492355-1-alex.t.tran@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/2025 3:28 AM, Alex Tran wrote:
> Auto negoation for DP83840A takes ~3.5 seconds.
> Removed sleeping in loop and replaced with timer based completion.
> 
You state this is a fix. Which problem does it fix?

IMO touching such legacy code makes only sense if you:
- fix an actual bug
- reduce complexity
- avoid using deprecated API's

Do you have this hardware for testing your patches?

You might consider migrating this driver to use phylib.
Provided this contributes to reducing complexity.


> Ignored the CHECK from checkpatch.pl:
> CHECK: Avoid CamelCase: <MediaSelect>
> GetByte(XIRCREG_ESR) & MediaSelect) ? 1 : 2;
> 
> This can be addressed in a separate refactoring patch.
> 
> Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
> ---
>  drivers/net/ethernet/xircom/xirc2ps_cs.c | 76 ++++++++++++++++--------
>  1 file changed, 50 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xircom/xirc2ps_cs.c b/drivers/net/ethernet/xircom/xirc2ps_cs.c
> index a31d5d5e6..6e552f79b 100644
> --- a/drivers/net/ethernet/xircom/xirc2ps_cs.c
> +++ b/drivers/net/ethernet/xircom/xirc2ps_cs.c
> @@ -100,6 +100,11 @@
>  /* Time in jiffies before concluding Tx hung */
>  #define TX_TIMEOUT	((400*HZ)/1000)
>  
> +/* Time in jiffies before autoneg interval ends*/
> +#define AUTONEG_TIMEOUT ((100 * HZ) / 1000)
> +
> +#define RUN_AT(x) (jiffies + (x))
> +
>  /****************
>   * Some constants used to access the hardware
>   */
> @@ -281,6 +286,9 @@ struct local_info {
>      unsigned last_ptr_value; /* last packets transmitted value */
>      const char *manf_str;
>      struct work_struct tx_timeout_task;
> +	struct timer_list timer; /* auto negotiation timer*/
> +	int autoneg_attempts;
> +	struct completion autoneg_done;
>  };
>  
>  /****************
> @@ -300,6 +308,7 @@ static const struct ethtool_ops netdev_ethtool_ops;
>  static void hardreset(struct net_device *dev);
>  static void do_reset(struct net_device *dev, int full);
>  static int init_mii(struct net_device *dev);
> +static void autoneg_timer(struct timer_list *t);
>  static void do_powerdown(struct net_device *dev);
>  static int do_stop(struct net_device *dev);
>  
> @@ -1561,6 +1570,8 @@ do_reset(struct net_device *dev, int full)
>      PutByte(XIRCREG40_TXST1,  0x00); /* TEN, rsv, PTD, EXT, retry_counter:4  */
>  
>      if (full && local->mohawk && init_mii(dev)) {
> +	if (local->probe_port)
> +		wait_for_completion(&local->autoneg_done);
>  	if (dev->if_port == 4 || local->dingo || local->new_mii) {
>  	    netdev_info(dev, "MII selected\n");
>  	    SelectPage(2);
> @@ -1629,8 +1640,7 @@ init_mii(struct net_device *dev)
>  {
>      struct local_info *local = netdev_priv(dev);
>      unsigned int ioaddr = dev->base_addr;
> -    unsigned control, status, linkpartner;
> -    int i;
> +	unsigned int control, status;
>  
>      if (if_port == 4 || if_port == 1) { /* force 100BaseT or 10BaseT */
>  	dev->if_port = if_port;
> @@ -1663,35 +1673,49 @@ init_mii(struct net_device *dev)
>      if (local->probe_port) {
>  	/* according to the DP83840A specs the auto negotiation process
>  	 * may take up to 3.5 sec, so we use this also for our ML6692
> -	 * Fixme: Better to use a timer here!
>  	 */
> -	for (i=0; i < 35; i++) {
> -	    msleep(100);	 /* wait 100 msec */
> -	    status = mii_rd(ioaddr,  0, 1);
> -	    if ((status & 0x0020) && (status & 0x0004))
> -		break;
> +	local->dev = dev;
> +	local->autoneg_attempts = 0;
> +	init_completion(&local->autoneg_done);
> +	timer_setup(&local->timer, autoneg_timer, 0);
> +	local->timer.expires = RUN_AT(AUTONEG_TIMEOUT); /* 100msec intervals*/
> +	add_timer(&local->timer);
>  	}
>  
> -	if (!(status & 0x0020)) {
> -	    netdev_info(dev, "autonegotiation failed; using 10mbs\n");
> -	    if (!local->new_mii) {
> -		control = 0x0000;
> -		mii_wr(ioaddr,  0, 0, control, 16);
> -		udelay(100);
> -		SelectPage(0);
> -		dev->if_port = (GetByte(XIRCREG_ESR) & MediaSelect) ? 1 : 2;
> -	    }
> +	return 1;
> +}
> +
> +static void autoneg_timer(struct timer_list *t)
> +{
> +	struct local_info *local = timer_container_of(local, t, timer);
> +	unsigned int ioaddr = local->dev->base_addr;
> +	unsigned int status, linkpartner, control;
> +
> +	status = mii_rd(ioaddr, 0, 1);
> +	if ((status & 0x0020) && (status & 0x0004)) {

These are standard C22 PHY register bits BMSR_LSTATUS and
BMSR_ANEGCOMPLETE.

> +		linkpartner = mii_rd(ioaddr, 0, 5);
> +		netdev_info(local->dev, "MII link partner: %04x\n",
> +			    linkpartner);
> +		if (linkpartner & 0x0080)
> +			local->dev->if_port = 4;
> +		else
> +			local->dev->if_port = 1;
> +		complete(&local->autoneg_done);
> +	} else if (local->autoneg_attempts++ < 35) {
> +		mod_timer(&local->timer, RUN_AT(AUTONEG_TIMEOUT));
>  	} else {
> -	    linkpartner = mii_rd(ioaddr, 0, 5);
> -	    netdev_info(dev, "MII link partner: %04x\n", linkpartner);
> -	    if (linkpartner & 0x0080) {
> -		dev->if_port = 4;
> -	    } else
> -		dev->if_port = 1;
> +		netdev_info(local->dev,
> +			    "autonegotiation failed; using 10mbs\n");
> +		if (!local->new_mii) {
> +			control = 0x0000;
> +			mii_wr(ioaddr, 0, 0, control, 16);
> +			usleep_range(100, 150);
> +			SelectPage(0);
> +			local->dev->if_port =
> +				(GetByte(XIRCREG_ESR) & MediaSelect) ? 1 : 2;
> +		}
> +		complete(&local->autoneg_done);
>  	}
> -    }
> -
> -    return 1;
>  }
>  
>  static void


