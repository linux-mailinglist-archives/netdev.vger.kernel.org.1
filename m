Return-Path: <netdev+bounces-258079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAVACycli2mTQQAAu9opvQ
	(envelope-from <netdev+bounces-258079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:31:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D497211ADC8
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4DF0304A226
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0DF1A9FB7;
	Tue, 10 Feb 2026 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp6xBSja"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AD528E0F
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770726662; cv=pass; b=o7aJerUPlklxhsvkWpiQCP8xH5UH89xWcDPT5cKBs6qWVZ40DGEao75DA74eKpUhshSEaryC47y5fe3KHQXTI/FsE0U5BEL69lr1DO7CcQQT4R37m2vvh8ml/J5qUQ5p9BsTxwtPlKZBRs/pxgXUmrkF4eZ9XfHjuSb5XH+ArQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770726662; c=relaxed/simple;
	bh=WFhdtqmFGwXw9s+XCmyl30N4Jo+BvlRJomo0IZ53WLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVJ+kZw7pUJRXrjOgTIqz3SZKqjnek+PnVkTFikSLJc1ktaSChlUGEDShQivY/hUMtXTP7O5/1s1Vg9I7EWXeQmTd1XDbrzCEFdGd2yDFoybICIU7YfZ2x4sO+6X7OH2QBjal+6GbSWpG6KZ3GqRS4UHtOOAETOvv9YGL2XPd9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qp6xBSja; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65a18bc4b1dso46482a12.3
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 04:31:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770726660; cv=none;
        d=google.com; s=arc-20240605;
        b=lqlzVCxwHtgKJqvn4fQeBWlgwU50oos9uTZyfEs59aQlX+oKyZwGzsKrzB7TLUGhJt
         Lvew5CITJiq87qdBorgsrv3RsWFrLMQac3Wh3gT3TpKyiwwqOgqjkcufGH8koPVVEkch
         NZB5N4TacRhctnd+2xpZpeXrTz1pPbA028dWPRLOK31kKBW3SSikeMmt525V11SeJCcj
         ytcymSUXuOPQtLkNqysIc4cOw1ulQPeobnYqtaIKioF4u3e71w8aVm45kS/g2qsCj0Rr
         B/CApagRAQt3PqW05DuTYFLCgfAc7Pb+iWmjkZ2SOXavjIc7GojWHVKoNsl6FwGPrhBk
         DyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WFhdtqmFGwXw9s+XCmyl30N4Jo+BvlRJomo0IZ53WLA=;
        fh=6EjRpy3ryf2V6fTRWKkoNvEudA+j5MbzykfKYJPkffI=;
        b=AuBva/td44V8Mg5a3Oh0mraLJBdYqo3JUhMuRutB14ELUs90JLOPnZO/I1/SWJPubV
         D4fUHzwiidHYOGxHLwqhgiy9OEcJEEKKQHYc/mZftQkmEWsMaqgZZ3d2Pj4geAfDawgk
         ozykXZevbuzds1+dZApwiQTX2VAGXKwJDoyHI8KKGjwHPHUiD3l6YY7+50wSeIuteQMf
         D5XAIY3JVwOLwPtxV5f8V1SDrXuHPWZ4W7MWnCkijoQIbKKExFnd6kwc+hZALUMLCl3n
         5whWHr+LY1GxQ1l8aoKz4btc8rsckNODVs1e4kfoq8lFmFvysbawHbnHDxrJmIqG3ttq
         pxPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770726660; x=1771331460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WFhdtqmFGwXw9s+XCmyl30N4Jo+BvlRJomo0IZ53WLA=;
        b=Qp6xBSjaXgV6oShiqVzEfVUsw6vsHNXVPupnLa6pvBp1YJXRxSw4O17N/J0GPPMfZs
         mOBSGOsHWl1dPvOyNg1efWidFAuFuGV+2QQqBwf3qSHrKndFG7O/rMV7DcGy2XdFT1fA
         /z5vuvF0ASVdfNaDR+d/t1m7G+yMfaCSK71veJWVQARI2R0t3xahQxehaQvm5aaQw0M0
         kW1Vxap+icaFkdWZCE/nA/nmuEC2Wz/6zmYtYyFPD0TZ7x9sbp9GTSEZargq24Urontk
         5Ub357Lm82ZlI6FA+iNHVU4wGmnmQtO5rP7YFww/rSt11lSPtL9ZtsfJ59cHs5mBc4mI
         UK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770726660; x=1771331460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFhdtqmFGwXw9s+XCmyl30N4Jo+BvlRJomo0IZ53WLA=;
        b=RBDOa3dZpqOfc0ffJT5kCp7acvaGYQh8/oGHR/IeLMClSdnbOlKqRQBq4De6A6J3d5
         Bo8bhmj7gTbTDodXfMJcVZ9vxXw3snzv6LbEaa70QZ4RpsEcPrCHXHJfec34VUPLw/+S
         QuWzpQrwC6dCssKz20l2p1jb+cR1V/FFqr0MeaKBno9bmYjj9oKxwPrX3ZtxZAUUfjCL
         aG5af7izFpJbApHbxJRajzuhVCbef1wOK1Ge3Yt2Fzy0KNNz3HjMyAqZkfH2EJvQFjr5
         oMPpDmdeLiwLXaPKs+QMwlsDsmehFH5wSOBHnOtX4IEr6n5NzNweReHdAwKMmsIyebh+
         FNjw==
X-Forwarded-Encrypted: i=1; AJvYcCVGfc90le0snqBjI9TwoZ/AoLd2Hvo7mvfl8WO72/yV7qT354is2XjD+vMooIWtoUiN8Ihiw2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmx+YruVOdMRcqDPe+HgCtkM8fwje3KedcW6VaJjiZLZpK+luQ
	1Z1iiyyyUAclXnSNNgvmscxHAQPMqO1TMWdJRbAUxIMF4T70xPa9XiwRk0JVKsZiODT7NcqZKyb
	nLAX+Amrt4jdxNZOs9KQFQCUHvcIGMEk=
X-Gm-Gg: AZuq6aLgvjZdfCS3wS30YJwgBKR63YRpjx2sc4NX9dpj1LqQpQQZMWgsoWEnQe+VYjR
	MHGEyof+tFF75GZfVOcnjy106ABpXwmTZj4P3SR6iExB4yyrttVHEoZJaMT57vmCJpHYxLkFoGl
	/gWMelHNebHrmHy475Gt2OUXCputQmOpE2A1lbt5JxMQL9L/rGMUUi3QPSRlFpQl0ZmsjgxwaFx
	bC0hXqKwGuLbYRjqcaKdRUFubBa8luaqba+iQ70BDAL0R/Ec+oWQcWQHvS2OCAc1o0ZJHt0aLlr
	a1Q9OUQ=
X-Received: by 2002:a05:6402:2115:b0:64d:4149:4923 with SMTP id
 4fb4d7f45d1cf-65a0ef26917mr529754a12.1.1770726659603; Tue, 10 Feb 2026
 04:30:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209163854.521415-1-dg573847474@gmail.com> <e44af88d-2a7e-4caa-b5a2-88ce1b49a8ec@trager.us>
In-Reply-To: <e44af88d-2a7e-4caa-b5a2-88ce1b49a8ec@trager.us>
From: Chengfeng Ye <dg573847474@gmail.com>
Date: Tue, 10 Feb 2026 20:30:48 +0800
X-Gm-Features: AZwV_QgnhDkrwlBTR01dpTP8mV5Teg-lacUpdCUNLiA3yH--fILVvoma8lWMSHE
Message-ID: <CAAo+4rVpp7g2hd+T6cx4qjahrgBUa3SXabYD7u5=M2yd93wnTQ@mail.gmail.com>
Subject: Re: [PATCH] fbnic: close fw_log race between users and teardown
To: Lee Trager <lee@trager.us>
Cc: kernel-team@meta.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, jacob.e.keller@intel.com, 
	horms@kernel.org, "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258079-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[meta.com,lunn.ch,davemloft.net,google.com,redhat.com,intel.com,kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dg573847474@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D497211ADC8
X-Rspamd-Action: no action

> > Concurrent teardown in
> > fbnic_fw_log_free() could clear and free the log buffer after the check
> > because there is no proper synchronization, leading to list traversal or
> > buffer access on freed memory.
>
> fbnic_fw_log_free() is only called when the driver is removed, after
> DebugFS has been disabled. Before freeing the buffer the driver sends an
> explicit message to firmware to stop sending new message.
>

Yes, the more noteworthy case is that an in-flight IRQ already starts
in response to one firmware message previously sent before stopping
the firmware.

Thanks,
Chengfeng

