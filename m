Return-Path: <netdev+bounces-288734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIwAIdjFCWpYpAQAu9opvQ
	(envelope-from <netdev+bounces-288734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 15:42:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE915613EB
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 15:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCA51300252C
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 13:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03E93B3C15;
	Sun, 17 May 2026 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="qTa0AAf6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YfCZF34z"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3F037CD40;
	Sun, 17 May 2026 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779025361; cv=none; b=mjQ9XBXj5zGX5yquobqgnbBxK7O084LY9oDyKKwssAybfxLPIDESr/nkOw7o2DbSLbYCa4tHbaibf0ug/vu30zUt0MkeOtpQr4nUZjMKG2H/tuk8wT60PBsCifZyGPsZbWV4HD1I1cAhPDWVuGEHwoKafNdOu0cNFPn95jHukKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779025361; c=relaxed/simple;
	bh=uCLlzZ1VB9CsuF48q3ymKHqwy9UD55apzvEeIU+6NZE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=m2RU4uPRzWbpfkg/SBvtYoA/AGIuJInX6jbpaMcU/60kJNPaBA1OHQmI1byFAb1mokdwMSi4uV+HZmYOLt5mjm7A9bsxqqvAihoRND7MTZwK81b7iPmKNxcfRZ/ktiWT3z+LlBtfxYg0Qcaqg4tRw9LsbG6kFwQ+Laon9YRuyOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=qTa0AAf6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YfCZF34z; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3A57140008D;
	Sun, 17 May 2026 09:42:38 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Sun, 17 May 2026 09:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1779025358;
	 x=1779111758; bh=i6VJ1wclJMY7X3R5d0WCQLv0badDSEvG8LWeHXW6B6c=; b=
	qTa0AAf6zbyU0w0t/xyW+6ht1H9PhZyloKSaYUDjZLEj6zRxcfC6sb2tZsn/tPlw
	Ik7UXIKSosKmNljP27CYZKdKMmJyRI1Zv6vojxWunKUCJ+ekkjn6JQFzZNL5yqdW
	xEV+ShC6qv3at+0oSweo8U/xhJhVB7QQw9Avex1hNoqaZgRB6HNOERP6qL9HqccX
	5ro3DfnoD+0bgwXtauy4P0eNTnyrFsErMFVrGkoUQENmrIZQZYxlF8wcjva2hg6c
	ofB+TgVBL/EWBPOiujUJDjLAjFpQymxCinFc6bLfG4ZpcwLYtRq+WZ1e0kdDb4bD
	pqbKRfaKUtf5ex+QEPnEhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779025358; x=
	1779111758; bh=i6VJ1wclJMY7X3R5d0WCQLv0badDSEvG8LWeHXW6B6c=; b=Y
	fCZF34zsPd2WMuDf3OWhgabb10BJ2Eu1XLgh0VRPYspoCUgTxkzxF24Uy6FXkehk
	f9P2vj4ZnYwKXnoMW9/Kg5ccywNwEIxtHVt7Wt4KOAFKnURkYFON4z0EXLwpmZgR
	0IyJyVcTB5OfFkgzVPNaVSlq1XD83Ocu4SOvoSZaw1m0/Kp348rkua+KrjiF5R6b
	1mezA6gkcrNCYJS9J8V60m5YlhbA+hEutoD4dKl8yt73q5KgyYDmvCTuYfzUkFXB
	8f5HjqMSArT2Asbr/5W5wGcCFU7bnVjWNHP0iuUWm7OGoP9S+oa6Qo3Lhlc3sZPl
	JlHGXavY5vYmjO/IYhyhA==
X-ME-Sender: <xms:zsUJamyIPyah8qdHHzL38j8YDFcx5qCa93E1n5jjGbS1oNv-1LeTsA>
    <xme:zsUJatHxvKS0ZLuXcQ2QsLbAmbjBpQJnZ1IuKz6dsgw8UaT3CCH7uCAiyJjvbuL2s
    tWsf2jHH0Yeu-wZGaw7M0B0aeDIeTd3bIAd2Kai4ESD7Ogl7LtCOV4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeeiudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtg
    grqeenucggtffrrghtthgvrhhnpedtffevgfethfevteduvdefleevkedtuddvlefghefg
    ieekffejteejveffkedthfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhn
    qdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepuddtpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopegtrghrlhdrlhgvvgesrghmugdrtghomhdprhgt
    phhtthhopegtohhlihhnrdhhuhgrnhhgvdesrghmugdrtghomhdprhgtphhtthhopehpvg
    htvghrrdhshhgvnhesrghmugdrtghomhdprhgtphhtthhopehluhgtrgdrshhtvghfrghn
    ihdrghgvudesghhmrghilhdrtghomhdprhgtphhtthhopegurghvihgusehigihithdrtg
    iipdhrtghpthhtohepsghrghhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhii
    kheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:zsUJaqeP8XB9tjFnz8oemPR4eT4FaF8tcJD9Y3o0Hu2RC7UFQE1eQQ>
    <xmx:zsUJaqOr4DbpcU6e5OCnUylGPRaIH9TalYrpFUR5EqGYvnpH6Z83cg>
    <xmx:zsUJamXv4V90btPbXIZjci9omDsMzvySvBCvTZEsr-Z35vEAdfYSZg>
    <xmx:zsUJaqy81dlMoWqABNPODwZA_24tLTAz0qu68SEvzfK8sOiMhSiJQg>
    <xmx:zsUJan5cdz5tDGRTy_5OOgmTb_CBFwU-xM9ZThWwu6Fd3pRu_dqBCQvk>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8CA472CE0078; Sun, 17 May 2026 09:42:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwxsY8mDWkpN
Date: Sun, 17 May 2026 09:42:11 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Carl Lee" <carl.lee@amd.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: krzk@kernel.org, peter.shen@amd.com, colin.huang2@amd.com,
 kuba@kernel.org, david@ixit.cz, "Luca Stefani" <luca.stefani.ge1@gmail.com>,
 "Bartosz Golaszewski" <brgl@kernel.org>
Message-Id: <2a9f6e2d-a58b-4e42-ae17-dc8b129c74e3@app.fastmail.com>
In-Reply-To: 
 <20260516-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v3-1-37ba4b6e9086@amd.com>
References: 
 <20260516-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v3-1-37ba4b6e9086@amd.com>
Subject: Re: [PATCH v3] nfc: nxp-nci: i2c: use rising-edge IRQ on ACPI systems
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2EE915613EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[squebb.ca,none];
	R_DKIM_ALLOW(-0.20)[squebb.ca:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,amd.com,ixit.cz,gmail.com];
	TAGGED_FROM(0.00)[bounces-288734-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[squebb.ca:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mpearson-lenovo@squebb.ca,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim,ixit.cz:email]
X-Rspamd-Action: no action

Thanks Carl

On Sat, May 16, 2026, at 7:55 AM, Carl Lee via B4 Relay wrote:
> From: Carl Lee <carl.lee@amd.com>
>
> Some ACPI-based platforms report incorrect IRQ trigger types (e.g.
> IRQF_TRIGGER_HIGH), which can lead to interrupt storms.
>
> Use the historically working rising-edge trigger on ACPI systems to
> avoid this regression.
>
> Device Tree-based systems continue to use the firmware-provided
> trigger type.
>
> Signed-off-by: Carl Lee <carl.lee@amd.com>
> ---
> Some ACPI-based platforms report incorrect IRQ trigger types,
> which can lead to interrupt storms.
>
> Use rising-edge IRQ on ACPI systems to avoid this regression,
> while keeping firmware-provided trigger types on non-ACPI systems.
>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: krzk@kernel.org
> Cc: carl.lee@amd.com
> Cc: peter.shen@amd.com
> Cc: colin.huang2@amd.com
> Cc: kuba@kernel.org
> Cc: david@ixit.cz
> Cc: luca.stefani.ge1@gmail.com
> Cc: brgl@kernel.org
> Cc: mpearson@squebb.ca
> ---
> Changes in v3:
> - Use rising-edge IRQ on ACPI systems to avoid interrupt storms
> - Keep using firmware-provided trigger type on non-ACPI systems
> - Refine commit message to focus on regression on ACPI platforms
> - Link to v2: 
> https://lore.kernel.org/r/20260312-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v2-1-362348f7fa30@amd.com
>
> Changes in v2:
> - Add missing <linux/irq.h> include for irq_get_trigger_type().
> - Link to v1: 
> https://lore.kernel.org/r/20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v1-1-9e20714411d7@amd.com
> ---
>  drivers/nfc/nxp-nci/i2c.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
> index 6a5ce8ff91f0..266dc231c47d 100644
> --- a/drivers/nfc/nxp-nci/i2c.c
> +++ b/drivers/nfc/nxp-nci/i2c.c
> @@ -16,6 +16,7 @@
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> +#include <linux/irq.h>
>  #include <linux/module.h>
>  #include <linux/nfc.h>
>  #include <linux/gpio/consumer.h>
> @@ -267,6 +268,7 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct nxp_nci_i2c_phy *phy;
> +	unsigned long irqflags;
>  	int r;
> 
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> @@ -303,9 +305,26 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
>  	if (r < 0)
>  		return r;
> 
> +	/*
> +	 * ACPI platforms may report incorrect IRQ trigger types
> +	 * (e.g. level-high), which can lead to interrupt storms.
> +	 *
> +	 * Use the historically stable rising-edge trigger for ACPI devices.
> +	 *
> +	 * On non-ACPI systems (e.g. Device Tree), prefer the firmware-
> +	 * provided trigger type, falling back to rising-edge if not set.
> +	 */
> +	if (ACPI_COMPANION(dev)) {
> +		irqflags = IRQF_TRIGGER_RISING;
> +	} else {
> +		irqflags = irq_get_trigger_type(client->irq);
> +		if (!irqflags)
> +			irqflags = IRQF_TRIGGER_RISING;
> +	}
> +
>  	r = request_threaded_irq(client->irq, NULL,
>  				 nxp_nci_i2c_irq_thread_fn,
> -				 IRQF_ONESHOT,
> +				 irqflags | IRQF_ONESHOT,
>  				 NXP_NCI_I2C_DRIVER_NAME, phy);
>  	if (r < 0)
>  		nfc_err(&client->dev, "Unable to register IRQ handler\n");
>
> ---
> base-commit: 7109a2155340cc7b21f27e832ece6df03592f2e8
> change-id: 20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-cda942530c60
>
> Best regards,
> -- 
> Carl Lee <carl.lee@amd.com>

Looks like a good solution to me, at least until we can figure out how to make this work correclty on ACPI systems.
Checked it on my T16 G5 AMD, fixes the issue. I'll put it on few more systems, but I'm confident it works.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by:  Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

