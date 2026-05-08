Return-Path: <netdev+bounces-285721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GWiBZWh/WmwgQAAu9opvQ
	(envelope-from <netdev+bounces-285721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 10:40:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD14E4F3D33
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 10:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75E41300E144
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 08:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A646E37A4BA;
	Fri,  8 May 2026 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGHbT7MM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FC534EEF3
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778229648; cv=none; b=eLWpiqZZLQxQsau03/ytZQBRw4Pm66hgewFN8x4z6f72WsjKRVqX2g0HDclLpzvQHwlAwqEEPQgD+B54qVZ1XyFjjXUHzn5vFcAM/dIHwHxgbQ2qlX+mzc2v6/dqD446wWIZTaud3FybS0XpvdWEijK9Ve2yju1Df72t46wUeAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778229648; c=relaxed/simple;
	bh=EYq2LaRS7/wE9O5fN1xxBdxqWDcVL5HSo4IraNzRrbY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdQYgRB5AkYzWhsSevd+kO1dmYF+dn88YIN9Knuf2kWvEt7ZDj9jtXj6F3KzDyt+D2mrDQS3zlKbtEkLhbf+xivheKZGOP0cVg2EMtW3qJ2TOuEvnZ9uz938o9wjhehVQJXWjy1dS8urJa3eWa6mv4KtUxh+LSDmjhtuMQ7fOCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGHbT7MM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso10432965e9.3
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 01:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778229645; x=1778834445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBrLMbZ1kBG0nwZ7F1fosUl/09LgLiME1ma02b9cG8I=;
        b=JGHbT7MMnXk23sSoRY1Z+7bVJfgpsb/OjJuIt/mXHgtAGYs1rP4s+54xTJTFG3bLSG
         ZaQuTVK3YMOAQYEo3rtxcYw+OB9tSCuejfBqz1HlR71clJY+vdFVYbZUnLsScmSWVvA8
         dtalmwm4L7oL5te/hKCt0+nPmq35Tr+wlLQHLSrIYCB1jObHO837cBqhFD1RRofGF59w
         5y/toyTrAVdebL05ycBJQE+8AGwYm5fbV/vu6jYEzdqRXcIs4gIbqxL+oETkLuvKYftd
         rH9fpccaMQN1OQKutp33KJxpCkKUmgmheT2uy/RLgx+ip/MGAJoGIknsar0Hs3YB0nQf
         /L3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778229645; x=1778834445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MBrLMbZ1kBG0nwZ7F1fosUl/09LgLiME1ma02b9cG8I=;
        b=mdh6ES9HnjXbItfN2WuGq/OQ6SIZGVsxuM9073fBOnujGSCyrQPDrqRyaE6dWxYHry
         m87f/L5ADLUVQzYiD7KR+EJ3YKChOIJsXlsSUlcjB7Bi2MSZJpiHmkqBcq4KSxF3zSdn
         QWje1OA6xzzZ88eGWIRDi+JuCi6aIqHm8PwA/SlB2QjANtIlhoN0SLB0RjYR/o4d10Oe
         Er3+tthz++wwLhMRzrAA+SL87S4DyfrY5OMFAOsSFWytqEhhhf0cHnYldtIqrTR/3mGT
         E4GVHvRKWwI8ueuuvCudQBL1R7Qz9XatTKZmeALJ6zcg1xvgUdE/CyX05xxrpF0N/hBF
         se+Q==
X-Forwarded-Encrypted: i=1; AFNElJ9trJG7ZKz9m70ZTm0hqY86mAyCmpKbAmQOp33DgkDCc0/8i/T6p+Wa2GLNWluF3EZZg34QdZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEP2h8T1u1xw45EEovlav1memiujtg/JMqU3T5DdjQ7SrAagd9
	KQqRR+P7rtHJCPl5QSG3M9anwfZ4gy/wfK6JPmdIeBJg0xIUKXdoKTe8
X-Gm-Gg: AeBDievUaxUSz5Yfy1VW0fgOTcPX/yFwLseDYQ7pTbd+6pKHUZfmOf2mFy0ai35jJb1
	NX4kbYvObu7huG4pkOs8vPrgG3+3fxiHPnw/AfJ/XlfB7fm+XJEceQlBRjbHE03eNZeGdU8CuPL
	uslMgWFI3N2DOr3yE7pbVlRnkuEXV4KikoC6ro74OyrKPoUZyvG3R6e9CQvBef/hBj/GqnZVFVj
	/3LuePhOOcTvVVX33i8po0CMJrU0DfYNRIT3IKafIXTefcQwcICigMqp9xf1Mk+oqyt63ntCQax
	1Hjx7CZl7lw6Wp4C5Y3CuJzQ819R64vCfi5ZeDeIZF0MGTc2c9IyRJiZ9/oFIxFxtD/jUMOOK3T
	nbQbLhOLafIjr99i34nv/Tw6DN7ZPMzpA/NCLqacUsPd88khiaojcjdtGvOEQmiEExS9F82ELYP
	lIKwnUe1xs8rimWI182GoKgGxZDZEgS5sVd3pLTssmVJKG2YgqBrA9hZgo5rDT+A/B
X-Received: by 2002:a05:600c:4703:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-48e676ac055mr25431025e9.21.1778229645361;
        Fri, 08 May 2026 01:40:45 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491bae13csm2688386f8f.29.2026.05.08.01.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 01:40:45 -0700 (PDT)
Date: Fri, 8 May 2026 09:40:43 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Greg Ungerer <gerg@kernel.org>, "linux-m68k@lists.linux-m68k.org"
 <linux-m68k@lists.linux-m68k.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "arnd@kernel.org" <arnd@kernel.org>, Greg
 Ungerer <gerg@linux-m68k.org>, Frank Li <frank.li@nxp.com>, Shenwei Wang
 <shenwei.wang@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC 1/4] net: fec: do not use readl()/writel() for ColdFire
Message-ID: <20260508094043.20f5f3fc@pumpkin>
In-Reply-To: <DBBPR04MB750044F98B1E719AD9DBD93E883D2@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260506142644.3234270-2-gerg@kernel.org>
	<DBBPR04MB750044F98B1E719AD9DBD93E883D2@DBBPR04MB7500.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AD14E4F3D33
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285721-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,nxp.com:email]
X-Rspamd-Action: no action

On Fri, 8 May 2026 02:46:38 +0000
Wei Fang <wei.fang@nxp.com> wrote:

> >  static void
> >  fec_stop(struct net_device *ndev)
> >  {
> >  	struct fec_enet_private *fep = netdev_priv(ndev);
> > -	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & FEC_RCR_RMII;
> > +	u32 rmii_mode = fec_readl(fep->hwp + FEC_R_CNTRL) & FEC_RCR_RMII;  
> 
> This is not an issue, but since you changed this line, the new code should
> follow the "reverse xmas tree" style.

Looking rmii_mode isn't even used until much later in the function.
(and then not very often)
Much better to read it just before it is needed.

	David


> 
> See: https://elixir.bootlin.com/linux/v7.0.1/source/Documentation/process/maintainer-netdev.rst#L380
> 
> >  	u32 val;
> > 
> >  	/* We cannot expect a graceful transmit stop without link !!! */
> >  	if (fep->link) {
> > -		writel(1, fep->hwp + FEC_X_CNTRL); /* Graceful transmit stop */
> > +		fec_writel(1, fep->hwp + FEC_X_CNTRL); /* Graceful transmit stop */
> >  		udelay(10);
> > -		if (!(readl(fep->hwp + FEC_IEVENT) & FEC_ENET_GRA))
> > +		if (!(fec_readl(fep->hwp + FEC_IEVENT) & FEC_ENET_GRA))
> >  			netdev_err(ndev, "Graceful transmit stop did not complete!\n");
> >  	}
> >   
> 
> 


