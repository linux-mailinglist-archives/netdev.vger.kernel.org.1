Return-Path: <netdev+bounces-263234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB6tBzbxpmk/agAAu9opvQ
	(envelope-from <netdev+bounces-263234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:33:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A1D1F1883
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AC80309E77E
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2083B4E94;
	Tue,  3 Mar 2026 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wu2aQcl0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H42LUBaG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AB537DEB1
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547807; cv=none; b=mubABv9bHGhXXBzFc72BT6dbZZq/W3/acw9pMuFuYfeRvz6PzGbemoiom201AIhYFQrBAcaiaAn6igwXqy6NyjgPGrjtAUNflRMOEY8FQpkj37n2lCKAWLTifLRDWmH6FJ9vvsoQKsefNXbPqW7MtKt9V+oB5Ad6ik5pb262a28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547807; c=relaxed/simple;
	bh=BqDASlU5dAk0KgpaOpsVyA/EwDB6UmMJzv95WA7BTXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jeOVyrEBDzSd0lXtmtjQwjHDc7RQqnURvbgib/2kd/gTnNTW/wyrF05dYo0tRQLf768a/rvvljT86Cv8wY6Gx/QC7fjmFqhYK7iA59bgvcbsM+YHFBsGpop6pqxUWl95D4p6dHiInzrNNnnUFvAaAdPxdCJ1Wt3OXdOoXJmUDI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wu2aQcl0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H42LUBaG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772547805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8aIntPegZIhEU1bj52/gaBuyNEv9BjODTP1DDhekn2E=;
	b=Wu2aQcl0G0hLt/hESWl48D+eBYwnHwCs97/k/vBF6eVa4gBTPFvfM9170ddTlrGAqqyiSS
	TS7goy6JIkQV2oI2qtWXem3OHK/wwW1Jn2Uj8RAOARCgF1k1fLYT0+5O5H0P/BH6X4ntuM
	qpc9uWTu3k9KXF23mRG0yQ/sb72KCJM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-LHOu2FdLPCmKBIfzlQFGDw-1; Tue, 03 Mar 2026 09:23:24 -0500
X-MC-Unique: LHOu2FdLPCmKBIfzlQFGDw-1
X-Mimecast-MFC-AGG-ID: LHOu2FdLPCmKBIfzlQFGDw_1772547803
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439b3a26ebcso2114104f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 06:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772547802; x=1773152602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8aIntPegZIhEU1bj52/gaBuyNEv9BjODTP1DDhekn2E=;
        b=H42LUBaGo3IhkAIjSlGV7H+pfp1fN7U1YZpWGRGouxXap8WO4j91/43qb7J+mSiw3t
         Tb5g0FuNsa8+3+est9pKht0tPg52vLi7Tiilnez4eRxn/jeJKUvCpbTfbO17prFxcqvJ
         tahIaA2ep8WqTW6EozmutWhVZyY3votAcweiCsebttesZKr0SmfVVy+hjxeSaxMomap4
         6YVSgGSE/dmY74yvUQ2osu8EENSfiQyLJ4rLkAdvWJQhS16WQMArsP26hlguzy//b7Ub
         +xMXu+7zqLmeKHg9Y97O1lShwvummZ2XzJ3RnmmjwVO/K88JeUlrAzhlrPEaj8SrXrds
         aJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772547802; x=1773152602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8aIntPegZIhEU1bj52/gaBuyNEv9BjODTP1DDhekn2E=;
        b=nlh6o12IWlAhx10lmHLRv+ybWt/i/1EUbe0638EkNULS6lZWwUaR/WUA8H3dcbrRqE
         CAKvy1D4lq5JXfjYWFq5AyJmaPYK8Fmr2oOO/pfVrEtzqfR012dzAsnb7iGGvsXjScHQ
         f1+HRZzaJg2rDrSX9ERraNrUewt1fD1MTjh9kvzzCg8CturoeSKVUykaClj3nRMtBhA1
         W2s3oJVMWH109jl/qrOjdAicZOPUAL7lxG0+I3hYAcokAzDrVMNPomUdswAQihCOkLEu
         ZGc97q7w/8ibYVuqaunzx+HWjrXPM1sjSW6UQbefzHZiMHoYUYJy7I9stcM0BhJkb1z/
         tU0A==
X-Forwarded-Encrypted: i=1; AJvYcCVnzp7oVrt39OXvElg2AY+0MaTNdpha738IGSHPLkCNZIxW5vhi/epfXbdOOU2Waorpb2HUYGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsQmPPEEpzlnok9vSYPEUN1PmnpVkhBX99eNwsyFYMjeX4XYIK
	XkMuz/wONolqtF/pXGn5VujFDjNDWp6yKOyvthkYa9YSHqWo9tJolQMFQ5br8N7nAyUskA+Aawy
	YBGNttnSrFFgVCgbpayDVGFxe6wnUoN6oTOztQyeyVTuWiYQAeCBJZ1lsrQ==
X-Gm-Gg: ATEYQzz5rKNiEKKUzbAjgnvbb5wgp3LKzuUVl2GoIx9lALJaqRW5Gni5yMFAeZv+KcY
	OVZwvWFvPutjU+5AHxpUC1CbjUITCDX59gcSxM8ee+UBH1BFyEVV0+L/TZ9HjrzFGFSdSSC9hmY
	9VxgH/dR3IPvPcrQv0wVqYcJ84Oqdgm0pcJTmuNxqvtOMWh2JnRe7nmu9KVA9d9gXibG8WGSIaW
	TfGjuoYXPWMt85pD8e6p3F+csKTNsYtJcnrHX3yWpEaZBquJqOl+Z997huSs+AOeyd5pR0z3Ii4
	GOWdaQCwDHRMuQgbP9c0CpOess4LHpMO+8YK/uc5VtIPJ5hNrKkbC16Wl9jUXQNl9hISoC0qeFO
	5+r2tYwNzXl8b9ipYalqkoH1F
X-Received: by 2002:a05:6000:1884:b0:439:af39:b406 with SMTP id ffacd0b85a97d-439af39bc50mr17936130f8f.24.1772547802251;
        Tue, 03 Mar 2026 06:23:22 -0800 (PST)
X-Received: by 2002:a05:6000:1884:b0:439:af39:b406 with SMTP id ffacd0b85a97d-439af39bc50mr17936071f8f.24.1772547801571;
        Tue, 03 Mar 2026 06:23:21 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b34b6252sm19286621f8f.10.2026.03.03.06.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 06:23:20 -0800 (PST)
Message-ID: <790d9b0e-cc3f-44e4-9ddc-b7f2ac3a3f8a@redhat.com>
Date: Tue, 3 Mar 2026 15:23:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 08/12] can: usb: f81604: handle short interrupt urb
 messages properly
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
 Vincent Mailhol <mailhol@kernel.org>, stable@kernel.org
References: <20260302152755.1700177-1-mkl@pengutronix.de>
 <20260302152755.1700177-9-mkl@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260302152755.1700177-9-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A8A1D1F1883
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263234-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 3/2/26 4:16 PM, Marc Kleine-Budde wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> If an interrupt urb is received that is not the correct length, properly
> detect it and don't attempt to treat the data as valid.
> 
> Cc: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Vincent Mailhol <mailhol@kernel.org>
> Cc: stable@kernel.org
> Assisted-by: gkh_clanker_2000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Link: https://patch.msgid.link/2026022331-opal-evaluator-a928@gregkh
> Fixes: 88da17436973 ("can: usb: f81604: add Fintek F81604 support")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/usb/f81604.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
> index 76578063ac82..c61bd30d1765 100644
> --- a/drivers/net/can/usb/f81604.c
> +++ b/drivers/net/can/usb/f81604.c
> @@ -620,6 +620,12 @@ static void f81604_read_int_callback(struct urb *urb)
>  		netdev_info(netdev, "%s: Int URB aborted: %pe\n", __func__,
>  			    ERR_PTR(urb->status));
>  
> +	if (urb->actual_length < sizeof(*data)) {
> +		netdev_warn(netdev, "%s: short int URB: %u < %zu\n",
> +			    __func__, urb->actual_length, sizeof(*data));
> +		goto resubmit_urb;
> +	}
> +
>  	switch (urb->status) {
>  	case 0: /* success */
>  		break;

AI says:

---
Should the length check happen after the status check instead of before it?
With the current ordering, if a URB completes with both a terminal error
status (like -ESHUTDOWN, -ENOENT, -EPIPE, or -EPROTO) and insufficient
data length, the code will jump to resubmit_urb instead of returning
immediately.

Looking at the switch statement that follows:

>  	switch (urb->status) {
>  	case 0: /* success */
>  		break;
>
> 	case -ENOENT:
> 	case -EPIPE:
> 	case -EPROTO:
> 	case -ESHUTDOWN:
> 		return;

Terminal error codes should cause immediate return without resubmission,
but the length check bypasses this. This could lead to inappropriate URB
resubmissions when the device is shutting down or has been disconnected.
---

IDK if 'status' is valid in case of short URB, possibly the patch code
is fine, but please have a look. Again, not blocking the PR.

/P


