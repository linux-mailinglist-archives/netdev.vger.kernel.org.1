Return-Path: <netdev+bounces-256193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHGtIn21gWkrJAMAu9opvQ
	(envelope-from <netdev+bounces-256193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:44:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 52072D656F
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6552A301CF59
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 08:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DC9395DB3;
	Tue,  3 Feb 2026 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrLTachw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sv6+gmwx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A0F155322
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770108280; cv=none; b=JJwZ0vD8aFJnsouKh7juIKe6yOeKRS3c4xzYvdozEXrcGSKra3qaLUONJypSbFYBt+gE6cPeAIRpTMy07GYXQJ2limsuMSrSJ/iuXGHJr2i6/sGP7wTV8Foc/xAXW+wDu6B00snKtF1RwqOFehRMnsmLgdfmnM1PDCGMeAc7aks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770108280; c=relaxed/simple;
	bh=c/MlIGyRe6Ua1hKekR0FD9JRU3veBk2Rq2u+/LF8An0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4PLiw35ufhgrzx9tg3G4Rt3IME3kUZUPKQjLPJYyhmj6knhDOxGvkwpJ7+nY6RhoM6Yh7w3MGgU0v+pt+q8F+vC/+bZL0dz4F9uTCyiFzQx7ofsjOxi3+dHfI7t/FFkUJhN1PF9DQWYOth5gx/saoeBAuZ3mQK8zjqdkA5i3I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KrLTachw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sv6+gmwx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770108278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgHLoc4JJmVQ+DPngHL651kkYSwBeL/ZVkdO3ynZe2Q=;
	b=KrLTachwdTNW1/0GOjExkeEUIetDqjSAdKM9lue5jOygPh25b1SZJ1qfZjbpwqrEqtPrWd
	Cm5UXg379g6K6vA1/bRJSnbttGqjpJgE2OdmEJo8ib2yU4CRe58Fg26iIzjFNNjCmAknPH
	XmF6F6BhrMbYBbXML1YSI6oh9BC0LZc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-FVhVLrx5MwiZ8LlH3_-LJw-1; Tue, 03 Feb 2026 03:44:37 -0500
X-MC-Unique: FVhVLrx5MwiZ8LlH3_-LJw-1
X-Mimecast-MFC-AGG-ID: FVhVLrx5MwiZ8LlH3_-LJw_1770108276
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fcf10287so4920572f8f.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 00:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770108274; x=1770713074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VgHLoc4JJmVQ+DPngHL651kkYSwBeL/ZVkdO3ynZe2Q=;
        b=sv6+gmwxcaS4rSTI5aPgrABvTFXRxbk7YnuehxEVfptDh446D544wBE/8K+HMSgGto
         3rBmY5uAflwOBWTxML8DYa2835TZ6RtrWuK5NadnEmayEZchIyY9iRp2xNFfjtsfJBgK
         VCxCwxxVIl8w28P69AmG7+6e7NJU21QMmeX0q8rFNFOFpFhelkNqgOLIOP3ZH9v0z4Pi
         RlRT9mk6i/j6etlDDW9ecLkZBFnX7+cjiuzPBiT/R5nL26p2bn8cc96Dn5gZnrDot+5M
         wkywuwEQMp0pWr+L2hIwclq0ulANHO4M/fa7ZvImrVfahWC6S0e5FasY5CQBGoVFHdWJ
         b8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770108274; x=1770713074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgHLoc4JJmVQ+DPngHL651kkYSwBeL/ZVkdO3ynZe2Q=;
        b=urI1NJLaleZ8pmM5NzzweAdsqaYJN+31lFJZNwqbiRWBp2z0Uw6OwsRxGLiokNVGQI
         WsfIr3ubGIsag8ApOyk9WqrzsnVVz0/6OhemkLA4/WxSrYfsZwYbKTuyI55HqLkqQqzr
         Qb8+N+SI5j8oHPN9t6FNqQzyKIJdVq09CtPmAhBiOiF8/gSIidvHSg8+BX2lEnag0+gr
         FEux0qfD7UZqmSMhfGwuSUiqeG1/SM5JENikE7H8KysRjR73oTRN0bxPEdvuAUnHTRXs
         NXqLEGRtL2yHtNxwrUWDrS8HVavWFMCEkuHTTvOZ5VdfHoatdlZBQJNPE54441Jw5wWT
         HyOA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ4jHTXfv861JwPA/wDE+9qVsFUaH19BdfKEDYO3lfRGM6yejEM47ffJryhdJiOPtx6BJTjzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxXnRe0rNfOlioDYG5Yj0z4Cyl7hNM4Bw11XRVA/C1iem9Ttf7
	iTWmV0qDv/Mf6EeOzkOZgWCE36ZZKJDqrTleANDlz7l90LX1T8BCQ+XEww2OuGncbvL++LTzyBM
	cIo9E0U3HHIQG174GdgQrawzrs8mF/4gjLXwOcd8oqOQ1arB6/UjrWI2v5RBBwvny2Q==
X-Gm-Gg: AZuq6aL9lZfJ0ZC/EYWclLK8VETaUQoOEWY1Pd/3cTUxjhRqAqJy5NMWOI1V6t80GRB
	oshei6bkNOi4/l4o00Y8l6alqo1+/VZ20ezcuvwAJT+nCmwuw/ulVZd1bDhx+wqxjiomh2e6mp2
	beXCzvZwXjHSIFjV9SKfw4Vd8a2nHz443/Ok9qkx5O6FpnzHvy1ohzrJmpfDRHQl6tPO6mtXrzo
	28ecGP3G3zNTRTNq2XtuMOP80/ZvsiJA4blj0hpB0BR1q6R+50uMNeJxG3QzN7XA9wcZtmnF+8y
	dpfUxen890wrJjGi1TiLxGlG4HfXLPRxhBymBN3wxkYwaHVRUZ27QdjkLqJNur2foCjNjN0rGbz
	Hh0IdJIvm
X-Received: by 2002:a05:6000:401f:b0:430:f241:a11f with SMTP id ffacd0b85a97d-435f3aaa5aemr19352657f8f.30.1770108274184;
        Tue, 03 Feb 2026 00:44:34 -0800 (PST)
X-Received: by 2002:a05:6000:401f:b0:430:f241:a11f with SMTP id ffacd0b85a97d-435f3aaa5aemr19352628f8f.30.1770108273800;
        Tue, 03 Feb 2026 00:44:33 -0800 (PST)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10f82aesm52194011f8f.19.2026.02.03.00.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 00:44:33 -0800 (PST)
Message-ID: <14cb0b22-ec39-43e4-a35b-22ad558b2e34@redhat.com>
Date: Tue, 3 Feb 2026 09:44:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] iavf: fix deadlock in reset
 handling
To: Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>
Cc: ivecera@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20260202084820.260033-1-poros@redhat.com>
 <20260202155813.3f8fbc27@kernel.org>
 <b064ca33-1d94-4c7e-b0d0-78430d8cd0ac@intel.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <b064ca33-1d94-4c7e-b0d0-78430d8cd0ac@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256193-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52072D656F
X-Rspamd-Action: no action


On 2/3/26 02:00, Jacob Keller wrote:
>
>
> On 2/2/2026 3:58 PM, Jakub Kicinski wrote:
>> On Mon,  2 Feb 2026 09:48:20 +0100 Petr Oros wrote:
>>> +    netdev_unlock(netdev);
>>> +    ret = wait_event_interruptible_timeout(adapter->reset_waitqueue,
>>> + !iavf_is_reset_in_progress(adapter),
>>> +                           msecs_to_jiffies(5000));
>>> +    netdev_lock(netdev);
>>
>> Dropping locks taken by the core around the driver callback
>> is obviously unacceptable. SMH.
>
> Right. It seems like the correct fix is to either a) have reset take 
> and hold the netdev lock (now that its distinct from the global RTNL 
> lock) or b) refactor reset so that it can defer any of the netdev 
> related stuff somehow.
>
I modeled this after the existing pattern in iavf_close() (ndo_stop), 
which also temporarily releases the netdev instance lock taken by the 
core to wait for an async operation to complete:

static int iavf_close(struct net_device *netdev)
{
         netdev_assert_locked(netdev);
         ...
         iavf_down(adapter);
         iavf_change_state(adapter, __IAVF_DOWN_PENDING);
         iavf_free_traffic_irqs(adapter);

         netdev_unlock(netdev);

         status = wait_event_timeout(adapter->down_waitqueue,
                                     adapter->state == __IAVF_DOWN,
                                     msecs_to_jiffies(500));
         if (!status)
                 netdev_warn(netdev, "Device resources not yet released\n");
         netdev_lock(netdev);
         ...
}

This was introduced by commit 120f28a6f314fe ("iavf: get rid of the crit 
lock"), and ndo_stop is called with netdev instance lock held by the 
core just like ndo_change_mtu is. Could you clarify why the 
unlock-wait-lock pattern is acceptable in ndo_stop but not here?


