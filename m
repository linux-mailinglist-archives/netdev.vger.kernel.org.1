Return-Path: <netdev+bounces-270955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Pk4M51bwmnQbwQAu9opvQ
	(envelope-from <netdev+bounces-270955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:38:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79916305B8E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7269330E26D9
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65C73DCDA6;
	Tue, 24 Mar 2026 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8QHwY64";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQKJvIux"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D483DD50F
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344669; cv=none; b=sWKe7WtvAnDQ6j+pe8rsYZ19sWMqwAsHHnYoj04twLabnIWlvZkrFLahTZzOjEK2PyyZycZa45jTHRXABdhTdEHvoXrqWZ074AzF9lG6FCeYuCAnbnCo5J5IrWuvo8WYfP9sxErU0NXII/OekTNWoT8KcMlKGUrFDeXSUCjvVJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344669; c=relaxed/simple;
	bh=wR0MYgvfRxRo7yJnIXk5WF1PsvOhj235sC9Q8JEhANo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2/DgFk8x/vRaJVBPGMxFIwE+TE3NVsF3AvNsJD9vy8cyLdvuTS1Jw+r4u6pt/loOdqXnGCq3Heo2osslxC1N3Sf3XbHUXAplAtgJ1j8kEvu3hcYMLeCKyE+wob7zmJn/+QIFujyM1YM8CCBzmHuYbdIMNuYisyOGHYtBR12Z6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8QHwY64; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQKJvIux; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774344662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XaXcf6JR5xlKse8eA50Q7AcTPnJWxIuFBt7NFS81ecg=;
	b=G8QHwY640bSDvq9V25MWFxSLHgeFl/LipdSzLMITKR6VoENcTknQF70vtsJjeUbWEGq306
	Bytq2a8IeapJPc/i7NytbvulQW5TXCZflUwNirHy/n8Y8UhzVj/25+GRN6Rj3+wiOUpZWs
	Y1Ynq7iAcbtqwDDmsj42zEFzrsFDQDY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-CNdpzr88O22UVCDGQOAh2w-1; Tue, 24 Mar 2026 05:31:00 -0400
X-MC-Unique: CNdpzr88O22UVCDGQOAh2w-1
X-Mimecast-MFC-AGG-ID: CNdpzr88O22UVCDGQOAh2w_1774344659
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48544725bdeso51636755e9.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 02:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774344659; x=1774949459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XaXcf6JR5xlKse8eA50Q7AcTPnJWxIuFBt7NFS81ecg=;
        b=RQKJvIux2yvZ6J5g2nNz+d9blf61jlG3ZKbIzF+9aqUknSNoSzrzhtLvqMWRDyorEN
         AUeIY5OS89nrSm5Psl2xXJqkGchJNLjAhBUeN2Ln0E0MNpZucHYRBOLALuoXoca5W3VH
         YP29dQoqGYxIqQZgyU7l+cfvH2Q+ZLllCmnStsyfbtswAYZjuKonzseWtdMvkFGEvcr2
         wau46cTb7aZBNgnmuzj8u59kBoJff+2PE3ROQBS3+IZBmgD86lR6gcp1bGdZu1GeSFsZ
         L2sum9du2lkPBNNrNIjrx/2bgKCyjIl7DHHR/+6dj6denuVG+M830DD5ddFEl6Z+HQiB
         rrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774344659; x=1774949459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XaXcf6JR5xlKse8eA50Q7AcTPnJWxIuFBt7NFS81ecg=;
        b=c5RayQpwsfRFMdqOdy3iPseF9AqSnEVOn3AksoZhxXiuwficHHr8jg2Kwx/J4nP4rz
         QeMh0OyHmjCp6xgpgUptcjQr6dulOApZeodnJFFhTiZ8R0eipGE6P1SymvmP2Ify8XI+
         rycGh1at8QVRp1kn7YqobIWKr22GglRZDlpEI3NXGRDghTvND7qH5VxCQ9zg3uZKv3sJ
         cf1zgKgm4DOtKrsLgh48t0XAfIkbl/0kBKsaTr/ccpHeCzfVAO88w9dAzCJJ5tc4LQo0
         bM4YTt50dmr+jwOelaTJSxTJOU6wKQvHw1ZwyG3Msrnbyq5o3t8CD86zuWWTdqw30VYd
         qUAw==
X-Forwarded-Encrypted: i=1; AJvYcCV8t/PRdIBiHpcV38/cyqKcyQ5s6zbpfuxyXKzLPFWtAH+TlW3JbSto3WZFrfaz5vObilyHEXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySUYe9Ycs6FdiD83aJoyI4MtQvHB1NkD6VlksM12RU58J2HZF3
	aVlV+ODlKvsJSFch/W2d/37spoyP75QpB+4axdLefJIlKBH3Ab0aQR5wOXQFc/QG9wFLXUTkYbs
	6Pu2Kfcr++JmdZaWzRkSKh6IkSS35fR8nOgRAs+BYqwMs+8zeZhfsZjidwQKXgXwTTA==
X-Gm-Gg: ATEYQzx5eR3tPpEwmuMZYyU113LJc33LMo1+RgM9/bszF4GK9v/u8xEeZVHyqojRoT2
	3f3oAq3NhM397u6C0FvO0lphCzdhcKmItYwFFE7Xo4nV4VcudVG/v8ijNRKF4IKAuCBpoYUShZw
	JJLNtMSxbuv5WQtqDzW3JgFD683doZQEBPPOMFNki9TWFnjRlpC0HyhmRE381MA2CGcCoXowDeS
	vjn06uB89u38/b5kuEio0h8bN1JZeBAnbC+cNf8fX2p1f2TmfOxvZEpYoU5ztUM1cwtdHzzl7Zy
	fQpLGv+l/elKofVWMidu/zd/hvz62AO1smb3E6WBiWeGc0HNPVIC8g0dTfHQN+ESytkHrR/40q6
	+yGGPN611gBDYLThFQtEzASh7uYanI6yLML5yTRVr4IZ2v3MvEYjVhyjD
X-Received: by 2002:a05:600c:a4a:b0:485:33ad:3c9f with SMTP id 5b1f17b1804b1-486fee1aed6mr204529055e9.25.1774344659159;
        Tue, 24 Mar 2026 02:30:59 -0700 (PDT)
X-Received: by 2002:a05:600c:a4a:b0:485:33ad:3c9f with SMTP id 5b1f17b1804b1-486fee1aed6mr204528485e9.25.1774344658667;
        Tue, 24 Mar 2026 02:30:58 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f81db8esm16734255e9.8.2026.03.24.02.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 02:30:58 -0700 (PDT)
Message-ID: <2232bb67-b82d-4ed9-9c88-85b37d3c824a@redhat.com>
Date: Tue, 24 Mar 2026 10:30:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc: pn533: add error handling for i2c_master_send() in
 pn533_i2c_send_ack()
To: Wenyuan Li <2063309626@qq.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gszhai@bjtu.edu.cn, 25125332@bjtu.edu.cn,
 25125283@bjtu.edu.cn, 23120469@bjtu.edu.cn
References: <tencent_1F05100756A32EDA9ECB2D342AFE8A3EBA09@qq.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <tencent_1F05100756A32EDA9ECB2D342AFE8A3EBA09@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-270955-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[qq.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79916305B8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/26 7:50 AM, Wenyuan Li wrote:
> In pn533_i2c_send_ack(), the return value of i2c_master_send() is not
> checked. If the I2C transfer fails, the driver continues execution
> without detecting the error, which may lead to incorrect device state
> or silent failures.
> 
> Specifically:
> 1. The ACK may not be sent to the device, leaving it in an undefined state
> 2. The caller (pn533_i2c_abort_cmd()) ignores the return value entirely
> 3. No error logging is provided for debugging
> 
> Fix this by:
> - Adding proper return value check for i2c_master_send()
> - Converting partial sends to -EIO and preserving kernel error codes
> - Adding nfc_err() logging with %pe format for human-readable errors
> - Propagating the error to the caller pn533_i2c_abort_cmd()
> 
> Even if ACK sending fails, the abort procedure continues by scheduling
> cmd_complete_work to ensure userspace is notified, but the error is
> properly logged for debugging.
> 
> Signed-off-by: Wenyuan Li <2063309626@qq.com>
> ---
>  drivers/nfc/pn533/i2c.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nfc/pn533/i2c.c b/drivers/nfc/pn533/i2c.c
> index 132c050a365d..4d771fe24f70 100644
> --- a/drivers/nfc/pn533/i2c.c
> +++ b/drivers/nfc/pn533/i2c.c
> @@ -40,8 +40,15 @@ static int pn533_i2c_send_ack(struct pn533 *dev, gfp_t flags)
>  	struct i2c_client *client = phy->i2c_dev;
>  	static const u8 ack[6] = {0x00, 0x00, 0xff, 0x00, 0xff, 0x00};
>  	/* spec 6.2.1.3:  Preamble, SoPC (2), ACK Code (2), Postamble */
> +	int ret;
>  
> -	return i2c_master_send(client, ack, 6);
> +	ret = i2c_master_send(client, ack, 6);
> +	if (ret != 6) {
> +		nfc_err(&client->dev, "failed to send ACK: %pe\n", ERR_PTR(ret));
> +		return ret < 0 ? ret : -EIO;
> +	}
> +
> +	return 0;
>  }
>  
>  static int pn533_i2c_send_frame(struct pn533 *dev,
> @@ -82,12 +89,14 @@ static int pn533_i2c_send_frame(struct pn533 *dev,
>  static void pn533_i2c_abort_cmd(struct pn533 *dev, gfp_t flags)
>  {
>  	struct pn533_i2c_phy *phy = dev->phy;
> +	int ret;
>  
>  	phy->aborted = true;
>  
>  	/* An ack will cancel the last issued command */
> -	pn533_i2c_send_ack(dev, flags);
> -
> +	ret = pn533_i2c_send_ack(dev, flags);
> +	if (ret)
> +		nfc_err(&phy->i2c_dev->dev, "failed to abort command: %pe\n", ERR_PTR(ret));

A single failure on abort_cmd() will emit 2 err messages, which is IMHO
way too verbose. Also send_ack errors are still ignored in most cases,
and errors from other phy (usb, uart) too.

I'm sorry but I see little value here.

/P


