Return-Path: <netdev+bounces-266620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GFSAAFOsWlCtAIAu9opvQ
	(envelope-from <netdev+bounces-266620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:12:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CB8262C96
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73BF330BC130
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B223C0607;
	Wed, 11 Mar 2026 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsB6mvni"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEC13CEB91
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773227336; cv=none; b=ktvIC+OGNwq0gPAOYWf0xZs+bIoumk0pZLY19G1Q6NroV83a7tUsg6jap0Bw02Sshfmq4PNzeBjvikTJ1xRY+OyM4CASOrtjq56DacpEnB31XJqqYz71UW1U1f5CUGY6mhWFaHL0fdAu7zqmW3rZokPcCbdpWNM1s5Cal0wwVjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773227336; c=relaxed/simple;
	bh=RhlzZEons67Y+S/3t6ZwDTE7rTzHjm4wxfVeUe7uRvo=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:
	 References:In-Reply-To; b=nrW0cQf+o310en/Cbna5aPmJxfuoR4abVgwQVg581s7ooj1yUGh70kdrvYL9HB/zf9IWWVW6t6NrVMwv/tsOPiuHPMtEd6X9L9iEm6izMidZJ7ifiWCg4Im2pylowg6OXtU+mSHID2fdrOA0jwyC6c8NUsF6wozuilIY8t9dNAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsB6mvni; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6631e0edde8so829692a12.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 04:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773227331; x=1773832131; darn=vger.kernel.org;
        h=in-reply-to:content-language:references:to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fcE2XkuvP0oPClcqbDxDBv2ScKwl7ow5f4zUZ2Q8nNg=;
        b=OsB6mvniyavbO6e7EZbysAaX8PiASZLOpbNOhTItyuxAuReBlSp7qOdIyD2gkc9DJl
         sW3YoEqfcjf0OhsBvBajaGcwV4nhHkTIWT+3Az2H9dk2EH2iFQ/qhHGTWLUxC5OS2fRA
         o/yEFavlUEjPzhN97UwPorUHRUcn2QivVNbQoCCaS7zdD9kG4RMf8dPfNYAzbwV7/kpd
         3wUTH2g0+lCaMMqVJJ+x+0IYQZD+705XHIWQb2GAanbqCY9YdZXFS1ddowAa9Pj7sgTG
         /fyoSTVQJ1IEqW849bo4Ni3dMlG06X/5mm3/tetBH7enbDh2mOPx+jLDVTWgAQug7vga
         mCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227331; x=1773832131;
        h=in-reply-to:content-language:references:to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcE2XkuvP0oPClcqbDxDBv2ScKwl7ow5f4zUZ2Q8nNg=;
        b=uBnnEsDO/TKGah7x7LYzUNLWzKhc9jlzaQdLEed3AqChRApCTyC1PmFSD0VEWjy3wt
         eBzMMU8Z6Ol20H6rcPv6lLbL7e6BV6ln2f1q2K6pbt94Ep1WZ+Mw0ToVKYkvD2U6n+xQ
         z2t3vxC1DKPbQqF7bcH0x6XgIUKJ76kAbQPNShPs1rP+fFzYjUrM+Y+2LQe94bZK3eaC
         GUl1qYDsdomT24XuFdF9zNnhpcidiZovpmudBRCiRQm3PLzaiv9lI0Kpo3KUzB3Bu9Ca
         IRxNbZ72+q16tXuXwVAswT8gp/UbidlTME9ZFVlu7XV7Bz48rl/5jyNjgMF7ml8xP+am
         BLog==
X-Forwarded-Encrypted: i=1; AJvYcCW6xSsYXtX19U4jPa5k44/YhPcvem/+6I3KDJP6Ak8RrZPYilia1iTYN/v5UEPqOmQXkF6jtlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT5g56WPiXiXZvE1RtOGFpDSQRX6oaD2vDoHDMtROBEsiWs4X9
	LMwt4qJNAInI/loAPeew+vyZ5K364JCPUh/ZMIxAsnzRL1+WffJNP+Ex
X-Gm-Gg: ATEYQzxhKbBYxCt8DH3rOmrvWGIDWJh5ZP3kfMZ2CmBJKVpIJhUia2BL4s0hhzYRIug
	hUGO+wjl8r847Qj/Rrt5tYfjEq9OLiQyfsUYPiSCwr5GT+y4BXGaWcmEErw8EBSyoONIYRMYsRl
	Egihi864e4L97fohwmC+Vb0rakGabUFrDQx8ZphFi9MPKFVvJVEASoPreaPl+GHT4YJpYy7/QNZ
	QSCB6vAuzVtuMHzTESgIHzGRV2Lv5n5GPE1/EIHycrScAayR6IiwRo4yYpub/SvplEAsCRdqy4O
	phYDuAYYwG2yTmQjtrm7LVe7XCEaYqQi2dpi6QHOsSJtM5fHk/9UNJfoDGMtZhvW8m/G8eP5d2k
	g0p3jSNWCcuyke+7X1bBoU/Rv/kk/dwx4LW18BuouDjzF1LB7hg5Y0SczPlLIjnmw5k/WO6XeTm
	ibzEAiyhxlieXnFuMQNIDYtLmt7GGF6My42Jf/+Ts=
X-Received: by 2002:a17:907:9452:b0:b94:1d92:7eb with SMTP id a640c23a62f3a-b972e1b12ecmr124646266b.18.1773227331120;
        Wed, 11 Mar 2026 04:08:51 -0700 (PDT)
Received: from [130.251.244.21] ([130.251.244.21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6631419b0efsm480850a12.1.2026.03.11.04.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 04:08:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------U0oltHvhNjgthrULRjO8iFJm"
Message-ID: <824cb117-1676-4a82-b77c-8908efdffa0e@gmail.com>
Date: Wed, 11 Mar 2026 12:08:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Luca Stefani <luca.stefani.ge1@gmail.com>
Subject: Re: [PATCH] nfc: nxp-nci: i2c: restore IRQ trigger fallback
To: Carl Lee <carl.lee@amd.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, krzk@kernel.org, peter.shen@amd.com,
 colin.huang2@amd.com
References: <20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v1-1-9e20714411d7@amd.com>
Content-Language: en-US
In-Reply-To: <20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v1-1-9e20714411d7@amd.com>
X-Rspamd-Queue-Id: 47CB8262C96
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266620-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucastefanige1@gmail.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Action: no action

This is a multi-part message in MIME format.
--------------U0oltHvhNjgthrULRjO8iFJm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/03/2026 10:26, Carl Lee wrote:
> The driver previously relied on IRQF_TRIGGER_RISING when requesting
> the interrupt. This was removed to rely on the trigger type provided
> by firmware.
>
> However, some platforms do not propagate the interrupt trigger type
> to the IRQ descriptor, resulting in interrupts not being triggered.
>
> Use the trigger type provided by firmware when available and fall
> back to the historically used rising-edge trigger otherwise.
>
> Signed-off-by: Carl Lee<carl.lee@amd.com>
> ---
>   drivers/nfc/nxp-nci/i2c.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
> index 6a5ce8ff91f0..6339586a6a1b 100644
> --- a/drivers/nfc/nxp-nci/i2c.c
> +++ b/drivers/nfc/nxp-nci/i2c.c
> @@ -268,6 +268,7 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
>   	struct device *dev = &client->dev;
>   	struct nxp_nci_i2c_phy *phy;
>   	int r;
> +	unsigned long irqflags;
>   
>   	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>   		nfc_err(&client->dev, "Need I2C_FUNC_I2C\n");
> @@ -303,9 +304,17 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
>   	if (r < 0)
>   		return r;
>   
> +	/* Prefer the trigger type configured by firmware.
> +	 * Some platforms do not provide it, so fall back to the
> +	 * historically used rising-edge trigger.
> +	 */
> +	irqflags = irq_get_trigger_type(client->irq);
Doesn't build, needs #include <linux/irq.h>
> +	if (!irqflags)
> +		irqflags = IRQF_TRIGGER_RISING;
> +
>   	r = request_threaded_irq(client->irq, NULL,
>   				 nxp_nci_i2c_irq_thread_fn,
> -				 IRQF_ONESHOT,
> +				 irqflags | IRQF_ONESHOT,
>   				 NXP_NCI_I2C_DRIVER_NAME, phy);
>   	if (r < 0)
>   		nfc_err(&client->dev, "Unable to register IRQ handler\n");
>
> ---
> base-commit: 7109a2155340cc7b21f27e832ece6df03592f2e8
> change-id: 20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-cda942530c60
>
> Best regards,

My ACPI NXP1001 table specifies ActiveHigh that properly gets translated 
into IRQF_TRIGGER_HIGH.

Sadly this seems to just show the same storm as before, I played a bit 
with the driver and noticed that it is simply broken on my device, all I 
get are timeouts if I read the NCI device.

I could get it working (reading tags) by hacking the driver a bit, first 
of all I disable the irq as soon as I get it, otherwise I keep getting 
interrupts when the device is in MODE_COLD that would end up setting 
hard_fault to EREMOTEIO. With that in place I re-implemented the 
enable/disable routine in nxp_nci_i2c_set_mode, and that seems to be 
enough to make it working.

--------------U0oltHvhNjgthrULRjO8iFJm
Content-Type: text/x-patch; charset=UTF-8; name="nxp.diff"
Content-Disposition: attachment; filename="nxp.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmZjL254cC1uY2kvY29yZS5jIGIvZHJpdmVycy9uZmMv
bnhwLW5jaS9jb3JlLmMKaW5kZXggNjZiMTk4NjYzMzg3Li4xYmI1OTk1ZmNkYjQgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvbmZjL254cC1uY2kvY29yZS5jCisrKyBiL2RyaXZlcnMvbmZjL254
cC1uY2kvY29yZS5jCkBAIC0xOTAsMTAgKzE5MCwxMCBAQCB2b2lkIG54cF9uY2lfcmVtb3Zl
KHN0cnVjdCBuY2lfZGV2ICpuZGV2KQogCWlmIChpbmZvLT5waHlfb3BzLT5zZXRfbW9kZSkK
IAkJaW5mby0+cGh5X29wcy0+c2V0X21vZGUoaW5mby0+cGh5X2lkLCBOWFBfTkNJX01PREVf
Q09MRCk7CiAKKwltdXRleF91bmxvY2soJmluZm8tPmluZm9fbG9jayk7CisKIAluY2lfdW5y
ZWdpc3Rlcl9kZXZpY2UobmRldik7CiAJbmNpX2ZyZWVfZGV2aWNlKG5kZXYpOwotCi0JbXV0
ZXhfdW5sb2NrKCZpbmZvLT5pbmZvX2xvY2spOwogfQogRVhQT1JUX1NZTUJPTChueHBfbmNp
X3JlbW92ZSk7CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmZjL254cC1uY2kvaTJjLmMgYi9k
cml2ZXJzL25mYy9ueHAtbmNpL2kyYy5jCmluZGV4IDdhYWFiOTJjNjE2Yy4uMWUzNDRlN2Fm
ZWFiIDEwMDY0NAotLS0gYS9kcml2ZXJzL25mYy9ueHAtbmNpL2kyYy5jCisrKyBiL2RyaXZl
cnMvbmZjL254cC1uY2kvaTJjLmMKQEAgLTQzLDE5ICs0MywyNCBAQCBzdHJ1Y3QgbnhwX25j
aV9pMmNfcGh5IHsKIAkJCSAqLwogfTsKIAotc3RhdGljIGludCBueHBfbmNpX2kyY19zZXRf
bW9kZSh2b2lkICpwaHlfaWQsCi0JCQkJICAgIGVudW0gbnhwX25jaV9tb2RlIG1vZGUpCitz
dGF0aWMgaW50IG54cF9uY2lfaTJjX3NldF9tb2RlKHZvaWQgKnBoeV9pZCwgZW51bSBueHBf
bmNpX21vZGUgbW9kZSkKIHsKLQlzdHJ1Y3QgbnhwX25jaV9pMmNfcGh5ICpwaHkgPSAoc3Ry
dWN0IG54cF9uY2lfaTJjX3BoeSAqKSBwaHlfaWQ7Ci0KLQlncGlvZF9zZXRfdmFsdWUocGh5
LT5ncGlvZF9mdywgKG1vZGUgPT0gTlhQX05DSV9NT0RFX0ZXKSA/IDEgOiAwKTsKLQlncGlv
ZF9zZXRfdmFsdWUocGh5LT5ncGlvZF9lbiwgKG1vZGUgIT0gTlhQX05DSV9NT0RFX0NPTEQp
ID8gMSA6IDApOwotCXVzbGVlcF9yYW5nZSgxMDAwMCwgMTUwMDApOwotCi0JaWYgKG1vZGUg
PT0gTlhQX05DSV9NT0RFX0NPTEQpCi0JCXBoeS0+aGFyZF9mYXVsdCA9IDA7Ci0KLQlyZXR1
cm4gMDsKKyAgICBzdHJ1Y3QgbnhwX25jaV9pMmNfcGh5ICpwaHkgPSAoc3RydWN0IG54cF9u
Y2lfaTJjX3BoeSAqKSBwaHlfaWQ7CisKKyAgICBpZiAobW9kZSA9PSBOWFBfTkNJX01PREVf
Q09MRCkgeworICAgICAgICBkaXNhYmxlX2lycShwaHktPmkyY19kZXYtPmlycSk7CisgICAg
ICAgIGdwaW9kX3NldF92YWx1ZShwaHktPmdwaW9kX2Z3LCAwKTsKKyAgICAgICAgZ3Bpb2Rf
c2V0X3ZhbHVlKHBoeS0+Z3Bpb2RfZW4sIDApOworICAgICAgICBwaHktPmhhcmRfZmF1bHQg
PSAwOworICAgICAgICB1c2xlZXBfcmFuZ2UoMTAwMDAsIDE1MDAwKTsKKyAgICB9IGVsc2Ug
eworICAgICAgICBncGlvZF9zZXRfdmFsdWUocGh5LT5ncGlvZF9mdywgKG1vZGUgPT0gTlhQ
X05DSV9NT0RFX0ZXKSA/IDEgOiAwKTsKKyAgICAgICAgZ3Bpb2Rfc2V0X3ZhbHVlKHBoeS0+
Z3Bpb2RfZW4sIDEpOworICAgICAgICBtc2xlZXAoMTUwKTsKKyAgICAgICAgcGh5LT5oYXJk
X2ZhdWx0ID0gMDsKKyAgICAgICAgZW5hYmxlX2lycShwaHktPmkyY19kZXYtPmlycSk7Cisg
ICAgfQorICAgIHJldHVybiAwOwogfQogCiBzdGF0aWMgaW50IG54cF9uY2lfaTJjX3dyaXRl
KHZvaWQgKnBoeV9pZCwgc3RydWN0IHNrX2J1ZmYgKnNrYikKQEAgLTMxNyw4ICszMjIsMTIg
QEAgc3RhdGljIGludCBueHBfbmNpX2kyY19wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xp
ZW50KQogCQkJCSBueHBfbmNpX2kyY19pcnFfdGhyZWFkX2ZuLAogCQkJCSBpcnFmbGFncyB8
IElSUUZfT05FU0hPVCwKIAkJCQkgTlhQX05DSV9JMkNfRFJJVkVSX05BTUUsIHBoeSk7Ci0J
aWYgKHIgPCAwKQorCWlmIChyIDwgMCkgewogCQluZmNfZXJyKCZjbGllbnQtPmRldiwgIlVu
YWJsZSB0byByZWdpc3RlciBJUlEgaGFuZGxlclxuIik7CisJCXJldHVybiByOworCX0KKwor
CWRpc2FibGVfaXJxKGNsaWVudC0+aXJxKTsKIAogCXJldHVybiByOwogfQpAQCAtMzI3LDgg
KzMzNiw4IEBAIHN0YXRpYyB2b2lkIG54cF9uY2lfaTJjX3JlbW92ZShzdHJ1Y3QgaTJjX2Ns
aWVudCAqY2xpZW50KQogewogCXN0cnVjdCBueHBfbmNpX2kyY19waHkgKnBoeSA9IGkyY19n
ZXRfY2xpZW50ZGF0YShjbGllbnQpOwogCi0JbnhwX25jaV9yZW1vdmUocGh5LT5uZGV2KTsK
IAlmcmVlX2lycShjbGllbnQtPmlycSwgcGh5KTsKKwlueHBfbmNpX3JlbW92ZShwaHktPm5k
ZXYpOwogfQogCiBzdGF0aWMgY29uc3Qgc3RydWN0IGkyY19kZXZpY2VfaWQgbnhwX25jaV9p
MmNfaWRfdGFibGVbXSA9IHsK

--------------U0oltHvhNjgthrULRjO8iFJm--

