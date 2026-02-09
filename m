Return-Path: <netdev+bounces-257900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDsoMBuIiWl1+gQAu9opvQ
	(envelope-from <netdev+bounces-257900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 08:09:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EEC10C55D
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 08:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5DCE3004427
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 07:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6DB2ECD37;
	Mon,  9 Feb 2026 07:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PgGjAHPU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEDD2FFF97
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770620949; cv=none; b=Pke5TVKJgENNYiJPg5YZVN2eDC/iL+fGKpX7Dd3k6fE/YFJdv/zKb45h5BGAhzHPL8ZRRSZq5lPbPk+5fCDc2kBN24z54NtylR4kp9k+2QlvhZwXE1gzZUze+bzCDqV+IiEnUWdYoc1ok6r9N3Pg/XuL2Ek6xoH0LGjvU6aXBX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770620949; c=relaxed/simple;
	bh=I1NGi+ekaGjV0E8Ubikboz6y8tPzpfia4WSzbvIpj90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ig9z77rrxKsiO7UGBFCX9KLmOcoDGQC0I8k9J366s5Zuya4AIQhq9XWdzjoxtfLyjrA9Qxh8GZPhAruI0HBRmE3S+hH8DXrC68aysw8CSEUjUu8hgZIJUUHv3FyPBl6THyAtLAeqBFuF+M3W3HKVF7dqiKug3sH+3K1oeSJ3k/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PgGjAHPU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4805ef35864so34057955e9.0
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 23:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770620948; x=1771225748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+wuaBU+jHlT/7T8bfgNNKqmz7w+AC3ayhXibObZLas=;
        b=PgGjAHPUGNCbWZp8KIEmQS9TfKUSg/z/OuZIVeEZuQCq9MyxCUm1qYj0mZObofCesY
         VVKc46buzkVTxS6MK7RuqIytyqcIvplBJoixjwnV/rdQJYiNpe2trah1AzNGsX6VMBEE
         AqTqpsFMWxORuaU4ST6GNw5hndiAGU8OPhkZtJEwQi95HVcBp1JrUF8/gNrbS+GJ3mnO
         Yay3G33oW/q9eHBpHJiCTi5UEsHWB3yTnbE4mIhh00lODoQ80f8lkUdYwcMHM0fcGMXR
         vgmUNYzeRVDZMOLaSwC1t8Z96G9n/OtPjf8ysIOqNUncPVTWpdBV6lbI95ezXaagfB93
         1hLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770620948; x=1771225748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+wuaBU+jHlT/7T8bfgNNKqmz7w+AC3ayhXibObZLas=;
        b=XRvUGV/MTqlYwga3a7ysiZ13orQ2Lzcj1QiZ3jdWcISHBQ0TuvdtmQqGb0//R1nt7m
         7wcLoQ/FiBXQxwFVAh27NME9IZBMocs7YLeVSzJrGbPL4exeoA9SiSjQ/bx+rbnsM8ec
         eECohhww3rU4BmUUaUJJdqTLGRII8SqIpFF/Wf/UhyB0cam48QkPVAoDuclHsvbfqb9+
         5FH41OUH70ifdf5T7Zy7EYSPBraPvss4Z3B/8Tmz1+OXWUiaXqlZvAkoIJJjLDVgw3zm
         vtlRvahzY7l2j8JQTdkQ48cMS28XqIjsH3NgKt2VnVuucWd1rcH9vTkIRSB/+rIoEcBg
         XqXw==
X-Forwarded-Encrypted: i=1; AJvYcCWm6D7dn7SuBnBJ7AxcbNvddSkDJwRq4B6qq9Viy01EttxlVLr8uUwhWGOgdLOp/7yRwj0E2eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdtBXdTXZaJzrtPU2zt1XaHDcRVDLyOtGcLxiZDJEQL1qJdcTC
	VIfS+p9NIe6/eiA9mulyyE6m9QESPOjPmkOGdso6ZXGOTcyurRUF78byr04bE+vhjW0=
X-Gm-Gg: AZuq6aJon54Y6cq4LMl2vPEMy33MPaYh3nY+cFTitqlK3rt2iP+Vvj7nXR2NN+vRC8Z
	eqljfS6Z5LIDFojdWuN4Aq8muX+t1SP7iYUxxlPldWlW6O4q5KQ3gU5HcEAKKx5EouetoG9LkAd
	D4sSk/na2X42uRNcsWbmS/IEHMyQPrsJ/meX1C6jPccpsGFUG0EGhGB5upO2U3eea2/iJ/Bd9Pj
	OGGP4fPi8IYkMYnzh4fJNthlnhBCQzX9BAkVjhd711bJzrhgvuVjihaVJ+PtxZ9IiDp2HCV+D4e
	1WdzhnTziaIe77mGGUjaf3qGS5QCwZRuVkfSRJ87+kaRIRgTlVERyLdQ0qnKw8G0DSP8NDqr2Iz
	2VVa2nKbyHEpx5nNsuk24BIY8f1IhOkxkVkKJqaqmTiYUtOrKdQZw2kgJAd/NjGzPTaYsL6mosg
	1jlHNUqjwV0cZXpqVI
X-Received: by 2002:a05:6000:2883:b0:435:a815:dd86 with SMTP id ffacd0b85a97d-436293b28f7mr16672811f8f.62.1770620947533;
        Sun, 08 Feb 2026 23:09:07 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629754c62sm22756355f8f.38.2026.02.08.23.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 23:09:06 -0800 (PST)
Date: Mon, 9 Feb 2026 10:09:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] net: ethtool: Introduce per-PHY DUMP operations
Message-ID: <aYmID1BOGmwb2rUD@stanley.mountain>
References: <aYXu0esD_wSjGTZm@stanley.mountain>
 <c9c6378a-14a3-440a-80b7-f48cdb06623b@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c6378a-14a3-440a-80b7-f48cdb06623b@bootlin.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257900-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 01EEC10C55D
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 06:04:36PM +0100, Maxime Chevallier wrote:
> > net/ethtool/netlink.c
> >     700 static int ethnl_perphy_start(struct netlink_callback *cb)
> >     701 {
> >     702         struct ethnl_perphy_dump_ctx *phy_ctx = ethnl_perphy_dump_context(cb);
> >     703         const struct genl_dumpit_info *info = genl_dumpit_info(cb);
> >     704         struct ethnl_dump_ctx *ctx = &phy_ctx->ethnl_ctx;
> >     705         struct ethnl_reply_data *reply_data;
> >     706         const struct ethnl_request_ops *ops;
> >     707         struct ethnl_req_info *req_info;
> >     708         struct genlmsghdr *ghdr;
> >     709         int ret;
> >     710 
> >     711         BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
> >     712 
> >     713         ghdr = nlmsg_data(cb->nlh);
> > --> 714         ops = ethnl_default_requests[ghdr->cmd];
> > 
> > Smatch thinks nlmsg_data() is untrusted data, so it could be out of bounds.
> > It's a u8, but there are only 52 elements in the ethnl_default_requests[]
> > array.
> 
> I see, then we also have the same problem in ethnl_default_start().
> 
> I'd expect the genl part to validate cmd (I haven't checked yet), but we
> do have a WARN_ONCE just below for the case 'cmd' is wrong, so we could
> definitely add some more sanity checks before accessing
> ethnl_default_requests[].

The WARN_ONCE() doesn't doesn't work as bounds checking since there is
no guarantee that the array will be followed by NULL pointers.  I didn't
see a bounds check for this, but I'm not an expert.

netlink_rcv_skb() <- receives untrusted data nlh = nlmsg_hdr(skb);
-> nfnetlink_rcv_msg() <- calls nc->call()
   -> ip_set_dump()
      -> netlink_dump_start()
         -> __netlink_dump_start() <- calls control->start(cb);
            -> genl_start() <- this is where the validation would be
                               when we call
                               genl_family_rcv_msg_attrs_parse()
               -> ethnl_perphy_start()

Also the WARN_ONCE() warns if we try to do a cmd which doesn't have a
matching operation in ethnl_default_requests[].  Every time we check
for missing commands it triggers a WARN_ONCE().  There are quite a few
which don't have a handler so I'm surprised that syzbot doesn't trigger
the warning and complain.  Here is a list of commands without a
handler:

ETHTOOL_MSG_USER_NONE, 
ETHTOOL_MSG_FEATURES_SET,
ETHTOOL_MSG_CABLE_TEST_ACT,
ETHTOOL_MSG_CABLE_TEST_TDR_ACT,
ETHTOOL_MSG_TUNNEL_INFO_GET,
ETHTOOL_MSG_MODULE_FW_FLASH_ACT,
ETHTOOL_MSG_RSS_CREATE_ACT,
ETHTOOL_MSG_RSS_DELETE_ACT,

regards,
dan carpenter


