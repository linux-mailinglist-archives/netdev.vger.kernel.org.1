Return-Path: <netdev+bounces-279620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tQ/iGwyJ5WmllAEAu9opvQ
	(envelope-from <netdev+bounces-279620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:01:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB0442621D
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3B39300363F
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C10212D7C;
	Mon, 20 Apr 2026 02:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CE9sNy7r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488901A6815
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 02:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776650505; cv=none; b=VhB4tcIUR3TIhU8Dbyak7U0oSxmAgNS08YvOPQs8t1evW6gbvYvF0ePtbg/uivbSRBJqRV7W7dgmle0KjZKM0AOsLW9YfU/4qwyn1Kzvu71eTGqlmfqEU2cK8knEoQsfHOW7KONlpE8rzTNwiKOfl/EF1JokSZrnv+TErJdinOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776650505; c=relaxed/simple;
	bh=UpAyP6pa/t4XNo1vh5zeET563vu6eTRrfaHWYqTHMSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gswy6MxFGOkut9YwsuZGHek0ONSC8lNqV5b69nNs3yi/2GMMlEYMzs7jeKAGyrZH1iZ7/T8H+CZpv9YPGkLHxtBKbw3soKo0ZHxiPklEWY8S8Nspr40ZpAedNyC96z1CVFlRnu5XdA1WKEgNeDygEsYHhnuErF3olqOMhut46p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CE9sNy7r; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506a7bbe9d0so21936971cf.0
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 19:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776650503; x=1777255303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slTCsHO8r/npdwfmKMYKZqfHhKdjw5nlwznNCByyHuI=;
        b=CE9sNy7rqZAeori2LLF4BdVSkKp1++WzmavAq6pPkFo60VIZFNkv+aOuCveEdD7JV9
         EOUbejPKUut7SmSLwyIzW1g/7C4OfxqDQTiZGCrFTuFrdsomhJ69wD9BgJ9BTMXjzbpV
         GwBinHYW6/FxvAapXKPW7mmFSTvh8LnX1U7lDyo9EkVRU2SHusUVN1nzXjHM7oAHRiUM
         iB7r+sanzji8KNqNnoNeWHmgqJdf2ht+TFRgDHF5/5GQBciduS/HiM4TQtXmkhGQmY2k
         TQtvVUBJ5WToB4o14zHG8ZHeDZ6UPH3Em94NbTWABc96GQzyulMxkH6KrfRqgAbB8c7H
         N9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776650503; x=1777255303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=slTCsHO8r/npdwfmKMYKZqfHhKdjw5nlwznNCByyHuI=;
        b=B0pwtDSRC5PDqPbhlirv+7nwbY6eBzaGchzZMVchI+hMcShCh3wIvXixRPsrlyEtmw
         yMRoLQUsmk9kZwSgSH/M77c/14RC8HoF6IibUiLMW9CLrFsGR0K34XxEefn2ecxoW6ys
         UB+VnLOgHBmw6etSJqHs0A/fN+zrc5EaxFW8EDKt4RuSGb+/yHutDDWrDrF1AhTP+oXU
         1k5s7ByfQeY0gdIALDD5gpuln1YmjqHuORkTsnL0M+hT5ZS5kd/2IsuxdJVP5s3l0kvN
         o+KzS2aihZUH4Bzd4BfcHS50RaNfOZ7HRD5CXkfeezj/1Yz3xQvPKCUQP4jdAyQazDDC
         brhw==
X-Gm-Message-State: AOJu0YxA1Y4XmlwkpTLikVGTdZXaQrvstRYxcmoFiwVEyOiIFjQ6zotG
	A0fhvT/FTBQq/g58ObtUqCAOioptaHtMH944ZujPWjAGir6dWS8UZvFD23h6pQ5fYam0KA==
X-Gm-Gg: AeBDieuHTX0EeJ/cTOzIH2gDV9IhNQktFNrvJNc7rJjMVg4GOZDCc3gvres2SHM9Nd2
	Y6uXiisoTDMpHZLUKJNdI8rrylKCzciiaAbgtWO4P0QaL2ZXgj+vgYx95t75X4LJek+HD7yDih4
	OkWTpfXHUJX8BgATLJ8Wt3q89UtjXr0CsC18jbIK4o1MSScIyc8+fJK0///yPEkcqfGuz0DRUA1
	zbkFuL2xmp2SU0UT07ls6u+o88+SD4O0IkkgHY97DVrufGG6KvuDY2BAIx2YbUrvMsw1J/mLJ0k
	oribdvJ1zaFClf/2Ohd/4FpyBZ1UWG7hvtDi4hxayE10b6Evmy0CTEVJPXpLaNGjICRrPXuoc5K
	bKkYnRGXbeCsJ0ZWBjEq1IcBzyKz96pIxQSXJLDONCUX0FjhE2YMdWmdBZ40afselR6JIfuPk6t
	Gu8BymvI/xF/jdn6OZP4JOxeKnEx6Dz2Jt7/lZpJCe6oLivdxyMMWFWn/T+N/M2i/CYghxhLpA4
	J3bhwIcXzvA9Wcw5eQosv/fbDSUTiYhhdzdiFI=
X-Received: by 2002:a05:622a:1f0c:b0:50d:f05a:9eb9 with SMTP id d75a77b69052e-50e36ca19a4mr161174061cf.36.1776650503269;
        Sun, 19 Apr 2026 19:01:43 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e392e351esm69759491cf.7.2026.04.19.19.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 19:01:42 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: horms@kernel.org
Cc: netdev@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: Re: [PATCH v3 net] rose: fix OOB reads on short CLEAR REQUEST frames
Date: Mon, 20 Apr 2026 02:01:41 +0000
Message-Id: <20260420020141.464510-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417120243.GB31784@horms.kernel.org>
References: <20260417120243.GB31784@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-279620-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAB0442621D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 01:02:43PM +0100, Simon Horman wrote:
> Unfortunately this conflicts with a recent commit...
> So perhaps you could make an incremental change to add that.

Thanks for the review. I've sent an incremental patch to convert the
skb->len check in 2835750dd647 to pskb_may_pull():

  https://lore.kernel.org/netdev/20260420015723.462479-1-ashutoshdesai993@gmail.com/

