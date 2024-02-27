Return-Path: <netdev+bounces-75409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0E8869CD3
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 17:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725861F24793
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13A31DFD6;
	Tue, 27 Feb 2024 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZWqsCVe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7431DFE1
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052784; cv=none; b=CnQcCr8Srj5RIjSZQxiOCALK9wkUm2bFw6F0XtMazRChx2K8HLHJ3CpAjG0r/SSvoJVS39KJjLGXpkjW5beWw2qVRieoaaVBggk0YRK5NOcJiJeCt6+5wumMbbQNsMrUe+6swkrwMKM/7I0+qZ444iDsThR4LcwSkMi7Db4U4As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052784; c=relaxed/simple;
	bh=+/uWOBUym6V4oHckKRbvNZmHSsTZ6pNyeB7kY1pPXn4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=erp07tju+NoTV9iK9qQK9bZ2qwgNs2AAFYLC+wHgSDgknH2g8fQGCoAqIZr33k2KdgsDm4C56qb+RoR/yzAtAjP0av5SMfBOiY89O80w4mri6eDAqyPxY2EY+H4h7YLEgSLW0ErtrO4WB5QwbrQ3loB9hnYDraF26CQtkK/LWRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZWqsCVe; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d26da3e15so2584613f8f.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 08:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709052781; x=1709657581; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r+BOxD15dVVcF1uZjErNh+Bp7GmHxrdsxzWssWtASBo=;
        b=VZWqsCVeyJ3IfFGM/K26unywqqGwGSinVlKHYMTdudle77KfRVFGNXPyAYrNyQkjdx
         htcdPm3EpeaiQu16BTzG8MXLoq1N19Z+fQ/zhLF+FQO4RhezHqoyzJhcLzlNxnmLB+pW
         w7EIs75+Md2t35BqPYNrIJAqvlMrUB85kiTSWB/rft6pYiDQKIk7VfjznlDFsz63AWxp
         GnIzEvkbjePI4dCcp6DgRQzkn4GQJMyqgqNAt97LV+fFxX+eOBcsLonYWCUJJA3Z2KkC
         9BsR7nF8nJUO+HYdngqRFnDO0v/DL/15Ehu2HBUZnFFMdVRPHc0NZiNb5sLzm3cT7fTx
         lYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709052781; x=1709657581;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+BOxD15dVVcF1uZjErNh+Bp7GmHxrdsxzWssWtASBo=;
        b=uVnFy5p6082lMSVJVikP7Qf/MeJBo4+06ISxxWq9iBH6iC0CB4KQzYXwJZh4t+8VHw
         duiIldGcYFHMc6gzLcNoc6xlvGrXOmgTyKqyYQ6j9jDRgaoakEhnrtlITmoagMNpkrpN
         3EU+0IvLDf07AtFfmxiyvNAWexzC3cyGxak9nar9PgY8hYE83BVLWlvNbXlJj4m2WeAI
         ekv6TUvy9ljc0peJioOZ/TuwVIzjiYm+4vUdm9onioHyrzqrJjKozXYxWMa1SC+G6oZW
         39s8XGTp0PceIhGVs84xx2v143Hc+////Q09xQI2TYQKZv9yc3JORoWwDc9KT4TA1od4
         klrQ==
X-Gm-Message-State: AOJu0YwPdeGKtXV4aZ8UWjgnmSKOyC4knABLOWbjFzG1OeG/lbuApe+/
	BkcbS7f+zUQtDF4tJub2XfcBUujIzaZuOY3ft1XkbNprk0jr7icx
X-Google-Smtp-Source: AGHT+IFCTAAVeJDfr2idxYCJBC2LNEVApqqoa+4fZG6wmy87f60gUzp9YIn4vr/dMWjVv0U1ELAlHg==
X-Received: by 2002:adf:ec01:0:b0:33d:e02a:c552 with SMTP id x1-20020adfec01000000b0033de02ac552mr5430837wrn.34.1709052781306;
        Tue, 27 Feb 2024 08:53:01 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:58f7:fdc0:53dd:c2b2])
        by smtp.gmail.com with ESMTPSA id z6-20020a5d4d06000000b0033d873f08d4sm11804857wrt.98.2024.02.27.08.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:53:00 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jacob
 Keller <jacob.e.keller@intel.com>,  Jiri Pirko <jiri@resnulli.us>,
  Stanislav Fomichev <sdf@google.com>,  donald.hunter@redhat.com
Subject: Re: [RFC net-next 1/4] doc/netlink: Add batch op definitions to
 netlink-raw schema
In-Reply-To: <20240227081109.72536b94@kernel.org> (Jakub Kicinski's message of
	"Tue, 27 Feb 2024 08:11:09 -0800")
Date: Tue, 27 Feb 2024 16:52:40 +0000
Message-ID: <m2zfvlluhz.fsf@gmail.com>
References: <20240225174619.18990-1-donald.hunter@gmail.com>
	<20240225174619.18990-2-donald.hunter@gmail.com>
	<20240227081109.72536b94@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Sun, 25 Feb 2024 17:46:16 +0000 Donald Hunter wrote:
>> The nftables netlink families use batch operations for create update and
>> delete operations. Extend the netlink-raw schema so that operations can
>> be marked as batch ops. Add definitions of the begin-batch and end-batch
>> messages.
>> 
>> The begin/end messages themselves are defined as ordinary ops, but there
>> are new attributes that describe the op name and parameters for the
>> begin/end messages.
>> 
>> The section of yaml spec that defines the begin/end ops looks like this;
>> the newtable op is marked 'is-batch: true' so the message needs to be
>> wrapped with 'batch-begin(res-id: 10)' and batch-end(res-id: 10) messages:
>
> I'm not familiar with nftables nl. Can you explain what the batch ops
> are for and how they function?
>
> Begin / end makes it sound like some form of a transaction, is it?

Yes, it's handled as a transaction, containing multiple messages wrapped
in BATCH_BEGIN / BATCH_END in a single skb.

The transaction batching could be implemented without any schema changes
by just adding multi-message capability to ynl. Then it would be the
caller's responsibility to specify the right begin / end messages.

