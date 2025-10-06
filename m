Return-Path: <netdev+bounces-228036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A99EBBBF91E
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 23:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFC1B4F29FF
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 21:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E39263F2D;
	Mon,  6 Oct 2025 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b="AeoFJ9O7"
X-Original-To: netdev@vger.kernel.org
Received: from out8.tophost.ch (out8.tophost.ch [46.232.182.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5302E25B31B;
	Mon,  6 Oct 2025 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.182.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759785820; cv=none; b=bfavZgJEgU6rSUZQ0L3aH6oZAcyZ6Fu13bfH1DgFd1LHJ6aDEScMyDrn43NMRxYF8fD2neE57HCi/9dVsIieHKt0/OIUa/7wkslJcjH9HrsoZQRsceXr/SxjiC69z9h1CH0jZg5WYgE3/KAppr41ogIWQKeVeEMpKyNK2BzOl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759785820; c=relaxed/simple;
	bh=GZgc4JOSb5TEtPwDyd3OBX08brdKWHfM92Ox8qh7Dm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgdgxJkZn73NyQk0g0dRTD4a9YATlo4pvbQhXr6FykR57TcAxbHHrUXepAyfq5WwPCxnlrzwV88kp4lC4MLY9mMAOV0dIEH6u7oVn6GczX4Q7EP3GDfkMIeGzxiCIN5V3Qsr7vNpXjCRMvBEypv1HMRtMT6nDmTSfXD2Td1z1vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz; spf=pass smtp.mailfrom=wismer.xyz; dkim=pass (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b=AeoFJ9O7; arc=none smtp.client-ip=46.232.182.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wismer.xyz
Received: from srv125.tophost.ch ([194.150.248.5])
	by filter2.tophost.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1v5sg3-007en1-Pr; Mon, 06 Oct 2025 23:23:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wismer.xyz;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0pZAPGrZ6v2KHOURbWDpcwwXqJAdIZc3pcZCHvS7/JU=; b=AeoFJ9O7vPQbufpHlE4i9vCZSA
	WXdtsBOoFOuXN6OUrfXQUuPQ7OsVlmNLqlU3wHXwLLvIEPlRQsSqCqcWta324jME6QqCpCMSXLuXr
	o5JEb7a2Np4ZlC8CKuER+0t4BnRrO+JrBfhy5VZzttAqV/WPapuokrrxC6pXsmWcUbc/F1xFUGGK3
	9wVMpj20YAKJLRUmkqreD+RtvsTOgJDUzy3oETkliUExBUjBF4P+Hviuik3pBnyxGJ9silbuLU4VX
	GcVw8G/fcm+nwhOGZESGa+5KiehPySzEx/xLSDKLYpAxnLsaEkI6U63gzOVGElRt9XXt163KGGXwF
	G8itSswQ==;
Received: from [213.55.237.208] (port=11683 helo=pavilion)
	by srv125.tophost.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1v5sg1-0000000DFVY-2SW2;
	Mon, 06 Oct 2025 23:23:25 +0200
Date: Mon, 6 Oct 2025 23:23:18 +0200
From: Thomas Wismer <thomas@wismer.xyz>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Thomas Wismer <thomas.wismer@scs.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] net: pse-pd: tps23881: Add support for TPS23881B
Message-ID: <20251006232318.214b69b7@pavilion>
In-Reply-To: <20251006150505.643217e8@kmaincent-XPS-13-7390>
References: <20251004180351.118779-2-thomas@wismer.xyz>
	<20251004180351.118779-6-thomas@wismer.xyz>
	<20251006150505.643217e8@kmaincent-XPS-13-7390>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Get-Message-Sender-Via: srv125.tophost.ch: authenticated_id: thomas@wismer.xyz
X-Authenticated-Sender: srv125.tophost.ch: thomas@wismer.xyz
X-Spampanel-Domain: smtpout.tophost.ch
X-Spampanel-Username: 194.150.248.5
Authentication-Results: tophost.ch; auth=pass smtp.auth=194.150.248.5@smtpout.tophost.ch
X-Spampanel-Outgoing-Class: ham
X-Spampanel-Outgoing-Evidence: SB/global_tokens (0.00018193972707)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuU/y90qE66sSRnDMDr00bJ/5J7IB3qaE4L/
 wgWexjLiqyu2SmbhJN1U9FKs8X3+Nt208ASTx3o2OZ4zYnDmkLm5Mv/tafLC72ko3Lqe/Da7zBA+
 4w86H9/QaYH/0wQ3416yXsfpoA8yRVY+nIJ7kGZoCtmoQhY2xrBb8C+tWUvqrqBKsSdhvd/J5sX5
 daZjkYsG4jVZi5Tfop5qjCZejidXzthz0vNkOX8Em4cj6D/wdR983ISMXlZYfkTQnVvsLb89W7vD
 6C469DIPe8wH3iOJTcWsqU26dvDcYIYzaKVPzizNp/gleLRyr2ddmlcu+i1jPgDrl7KDWN+JeAU8
 1aNgksp0UtIrN0U07614AkdB++MTbkn6z1fsm8NoMVdUr8MDPUrsZkS8fIjQg/OlnCq9era6RvWE
 xGjaMpBDSCziBywD4A8JEs8nAB07i3qQt2GCxqdhJ42egOXnLvBjaBHojvcdCFSGnAoJdmBrbnML
 ysTZI7fFfQwiuwD2LcLdqjNFmtMtCFuKzK3WYzvpld0/yccMnl06aHo07R+V2VbvDXc+galx1KGI
 Pp5jnkiI48S3blKfwQpggXpr4ijI5V97nizzgiBlcUwLhZK/ZHw1RdpNQJ37uqLsFt7+YGhJkDU9
 4+PQCJgyeQ5hmX4W3XfjuZq3ey7jWD75mz2FgepuKE1QHL+v8HSjw4E9FZ48n35YGxLcRm31r7HJ
 L906rtNSlbyOZqJAl0NcWR3h5RCCpdhlI2FswyUM1YB4pb6NihzVEQJD0k3NJ3BxI7jJWMBode2U
 Svel4Ph4LtRWGzmVykX/svZHtlcv4/x61HBbxR8gr/U0flMcy2Vi/IcBgY4ane5tOXPRIqHUx6+W
 zGK5Hg6zly/hm7kTCa25PmFuNjYUvwsQEI5UkfpCg7AUhDMCozAGWaBw5toun3z41wwqu7ky126C
 6EbUtvvf6B6B4ZRmzK1iYB13Bc9wKsgJWYDM7fs8i/Lg4VMmqeqQOhF8kMn3arb1xVlaLjgbxjTB
 gAHkgTtbIGX4Gktj7c2CONolFYbP7eetTUcNPZF8UuWWRQPHxHs4uWfEMXRAPK2SKfA9ZVlk6A0o
 BI++AftmkTovo3l38nh3FsWAjsNLvCvQNtXl1Kc2a+wlKs+ogYIxcMllcGL2FYQA/TYqr07UQr9N
 8YzZ1OXdAJhrEGn8vjZdfatsJHAzgC46MYYXOcKJkR5mWDA3wLMqtkpqhq8QHjwHB17Mh03hOC2D
 8X08bmfUo2hx63fUqSBCUpmH010fZI9bHEjTkiJxSPqFbdrqtFE8gK0UxPGon/0gulkiYXfVWWO3
 KRWMcR+Z5yTvtzkwsDU=
X-Report-Abuse-To: spam@filter1.tophost.ch
X-Complaints-To: abuse@filter1.tophost.ch

Am Mon, 6 Oct 2025 15:05:05 +0200
schrieb Kory Maincent <kory.maincent@bootlin.com>:

> On Sat,  4 Oct 2025 20:03:51 +0200
> Thomas Wismer <thomas@wismer.xyz> wrote:
> 
> > From: Thomas Wismer <thomas.wismer@scs.ch>
> > 
> > The TPS23881B device requires different firmware, but has a more
> > recent ROM firmware. Since no updated firmware has been released
> > yet, the firmware loading step must be skipped. The device runs
> > from its ROM firmware.
> > 
> > Signed-off-by: Thomas Wismer <thomas.wismer@scs.ch>
> > ---
> >  drivers/net/pse-pd/tps23881.c | 65
> > +++++++++++++++++++++++++++-------- 1 file changed, 51
> > insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/net/pse-pd/tps23881.c
> > b/drivers/net/pse-pd/tps23881.c index b724b222ab44..f45c08759082
> > 100644 --- a/drivers/net/pse-pd/tps23881.c
> > +++ b/drivers/net/pse-pd/tps23881.c
> > @@ -55,8 +55,6 @@
> >  #define TPS23881_REG_TPON	BIT(0)
> >  #define TPS23881_REG_FWREV	0x41
> >  #define TPS23881_REG_DEVID	0x43
> > -#define TPS23881_REG_DEVID_MASK	0xF0
> > -#define TPS23881_DEVICE_ID	0x02
> >  #define TPS23881_REG_CHAN1_CLASS	0x4c
> >  #define TPS23881_REG_SRAM_CTRL	0x60
> >  #define TPS23881_REG_SRAM_DATA	0x61
> > @@ -1012,8 +1010,28 @@ static const struct pse_controller_ops
> > tps23881_ops = { .pi_get_pw_req = tps23881_pi_get_pw_req,
> >  };
> >  
> > -static const char fw_parity_name[] =
> > "ti/tps23881/tps23881-parity-14.bin"; -static const char
> > fw_sram_name[] = "ti/tps23881/tps23881-sram-14.bin"; +struct
> > tps23881_info {
> > +	u8 dev_id;	/* device ID and silicon revision */
> > +	const char *fw_parity_name;	/* parity code firmware
> > file name */
> > +	const char *fw_sram_name;	/* SRAM code firmware
> > file name */ +};
> > +
> > +enum tps23881_model {
> > +	TPS23881,
> > +	TPS23881B,
> > +};
> > +
> > +static const struct tps23881_info tps23881_info[] = {
> > +	[TPS23881] = {
> > +		.dev_id = 0x22,
> > +		.fw_parity_name =
> > "ti/tps23881/tps23881-parity-14.bin",
> > +		.fw_sram_name = "ti/tps23881/tps23881-sram-14.bin",
> > +	},
> > +	[TPS23881B] = {
> > +		.dev_id = 0x24,
> > +		/* skip SRAM load, ROM firmware already IEEE802.3bt
> > compliant */
> > +	},  
> 
> You are breaking Kyle's patch:
> https://patchwork.kernel.org/project/netdevbpf/patch/20240731154152.4020668-1-kyle.swenson@est.tech/
> 
> You should check only the device id and not the silicon id.

On the TPS23881, the register "DEVICE ID" reads as 0x22 (Device ID number
DID = 0010b, silicon revision number SR = 0010b). On the TPS23881B, 0x24
(DID = 0010b, SR = 0100b) is returned. Both devices report the same
device ID number DID and can only be distinguished by their silicon
revision number SR.

Unfortunately, Kyle's assumption that the driver should work fine with
any silicon revision proved to be wrong. The TPS23881 firmware is not
compatible with the TPS23881B and must not be attempted to be loaded. As
of today, the TPS23881B must be operated using the ROM firmware.

> Regards,


