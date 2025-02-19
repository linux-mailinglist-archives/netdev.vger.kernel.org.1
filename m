Return-Path: <netdev+bounces-167609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435E1A3B082
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 05:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F833A683A
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 04:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D111A1ADC93;
	Wed, 19 Feb 2025 04:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7mxj13W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2D195B37
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 04:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739941003; cv=none; b=oXq8rBWhO/R0ckoiwyG1uAvpsQ7e1T1k8jl+Z+ylZ/8gZ+kKphZ3St/SdwNmTUIMG9KzMXMyvR+tGwyZvdNqnaqJJgDELIeJOL0dUqO3ZQXvmDGwASARTIjIgIQMIg5KjwK0n6rP/gP/cjGpaEQgE8TzN7Kyd5yZClApACSJ8So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739941003; c=relaxed/simple;
	bh=jhs3M7usSiXnLZNXOYNBB8JQ+qAfN8SRX2CxStcPBz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYTDWpD5L5dgNYLlSb7sup9zZlrO1awFBaWiKYv7sJrdRRN+7pB1cNa77D+IWtylFWPYUdrVAzOCnTPGdjWfC/Li4IdZkbEgfAJsX3q4+0sgiwbgsriS3ik34Px0N8/PY54GkVYxVpXESVzXxuRfvISlIgV94vRyCODm+Y4BNA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7mxj13W; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220d601886fso83709375ad.1
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 20:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739941001; x=1740545801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UgqlCB0JDgU8fRAvFcDJUVMn948LAMJRQQBbICZcAYw=;
        b=W7mxj13Wy+XAaboDTuZBt7SkkYCKVxYd+nwni71bgmz8YaobOV8olwTCflma49AHQm
         unPZ5jmToHIvJoK8cr305Lfi2mRIlqdrEmSxDT50UjkdKw0IJV4sVG74z+j5Fa6EgHf/
         V02vjzwsLwjjpy+LcbSJyaObpzN3GNE4aE0Bz+7LiZeKrQAeXTDJBTYLn8IjqlZos7L0
         TaCmXKiOBN3kMGSlzVXsWXTrEFDH6I6KSTVIu8yTo1KQ1HyIUYUxiejo3/dxiUQ7Dnws
         /PATYKHvTn3jLu2L7upJoOpHM8rT8NjcQIEYV0u9MTxCTr98vbsTl5LpLrwJn27HO7vn
         fvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739941001; x=1740545801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgqlCB0JDgU8fRAvFcDJUVMn948LAMJRQQBbICZcAYw=;
        b=AukjxgxHCosxSGegnQ9CQ+keN93uy5gSnpm8NbBZWTHAlbRgr6vSrG7Nybn6x8RT/a
         cf4fyRwpdvc5my28FC11TFBvvhJn16xAyk79AYdad8o4PgDi+kjwhDH+mzshQg4fvRFm
         jA9tIXQqeB7yPl5QwulwOgdTxrlJtPlvXi3ZIqSQPiLnVtLvWXHJNHuocrTSeEby7n4/
         RCp6D59c3E8H5j5/4jGwWb9FjllX51lqIUbh4Spf8YdpDsanyjunzwE2WmYdwLB9S4uq
         D5eKKHw2T7pLyoztbj2B1JzXsRbLToGy52sEZ2HzZI3IRCRgaV/uTgjqt8UD2wto2a8C
         9AFA==
X-Forwarded-Encrypted: i=1; AJvYcCUNaIuD9iSfhm7ac2ubaMdNcZsYQPfjomKh8sSvIs63zAX8gZgyN5gtyVToct0xt3yii8PaRGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpBJ9FPFhyKVH4O+GB0MP5MS7SE5lsVMBetw7b6oVdz9WUpKjJ
	VbQ6340WLf/cQGrmL/4kvoACWhjE1HJuYGkMSFM0QTtJVxoPlcs=
X-Gm-Gg: ASbGncsWCW6fspRZjrpTFmUJFhHMN/1DT3cR6J7nT1XkmsxWTkwjP1gAspH5hGbwd2C
	DVG8L1MG7I4a/9/psuKu1ltv0vD0kMvV3LjGLKA7I2f+Y/oVV/nFxbvs2Op9rooIUF8iNfPdwbF
	CS0axmaYW0Fda6+uF8ijxxWTP/mvotDnbKzwL+DohiSVFUFLbymgFUiNHXbZicGrMdtMIEvVrs/
	Zd7Qmo+tehyeE5a7lbUbXtwBXG2QTnMj4V42xMZ3wJlnXCaF8PzWCVKVbjxpJvoPt2YY5N59s6C
	+ZLdKV6v/rHfsoE=
X-Google-Smtp-Source: AGHT+IHuRLUDW+cS+W1XhqOJmdxhWBu9C0kFDsykyF/azRUHBPEKq/Uhkg9Gj8tHD582Cbgr7QWKzw==
X-Received: by 2002:a05:6a00:3d49:b0:725:e37d:cd36 with SMTP id d2e1a72fcca58-73261779909mr28151429b3a.2.1739941001544;
        Tue, 18 Feb 2025 20:56:41 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-adb5a92d3basm10051201a12.75.2025.02.18.20.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 20:56:41 -0800 (PST)
Date: Tue, 18 Feb 2025 20:56:40 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v4 10/12] net: dummy: add dummy shaper API
Message-ID: <Z7VkiOkRxL3vOL0G@mini-arch>
References: <20250218020948.160643-1-sdf@fomichev.me>
 <20250218020948.160643-11-sdf@fomichev.me>
 <20250218190940.62592c97@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218190940.62592c97@kernel.org>

On 02/18, Jakub Kicinski wrote:
> On Mon, 17 Feb 2025 18:09:46 -0800 Stanislav Fomichev wrote:
> > A lot of selftests are using dummy module, convert it to netdev
> > instance lock to expand the test coverage.
> 
> I think the next version should be ready for merging.
> What should we do with this patch?
> Can we add a bool inside struct net_device to opt-in
> for the ndo locking, without having to declare empty
> ops? I think more drivers could benefit from it that way.

Awesome, will drop this patch and add another one with a bool opt-in!

LMK if you prefer other name or a better comment:

@@ -2456,6 +2456,12 @@ struct net_device {
         */
        bool                    up;

+       /**
+        * @request_ops_lock: request the core to run all @netdev_ops and
+        * @ethtool_ops under the @lock.
+        */
+       bool                    request_ops_lock;
+
        /**
         * @lock: netdev-scope lock, protects a small selection of fields.
         * Should always be taken using netdev_lock() / netdev_unlock() helpers.

