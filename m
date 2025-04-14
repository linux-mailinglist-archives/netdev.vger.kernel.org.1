Return-Path: <netdev+bounces-182471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75567A88D58
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A91C3B2AF4
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21361C8638;
	Mon, 14 Apr 2025 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6zhuDRU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5764A1B3F3D
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 20:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744663720; cv=none; b=ep16jhqBr6fqmA6otcUTjBamu8BI6m+86hITR1mtziqqyqP5YbXITA6mcYrthKnpaP++M65hjleLGTy4uVvblkKsvqpn8Fl+Jkw/esEJ0jFhwCYqnxfdEdP706pvmuFPR+NVW67hmw7wuvnA9NgN8rSjwuLYjCSbUyrkJJjC2Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744663720; c=relaxed/simple;
	bh=9QUjS3Hdhpxn5Wk5J5Qq/Potircc3xTO6s9KXP5tId4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8VeILgKdqO/PxgkVTygdMcSss1v3IF1zWxsNyxxa5pa58+rKR5qZbx31k7HAIH1+aYw1PDqz0QxXAU9I8wx3Uy7T00Nj+agTjJn6nXUADh6MUpkQOvdOqNLWAnOLvicBKNiicR4dGt1bRBd7mJ9tuEzid9WbbxIK4QyJf4+tnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6zhuDRU; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-739525d4e12so4347406b3a.3
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 13:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744663718; x=1745268518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T9tk6CJZkAx7VMPFGCksrX4w7MMdB53eC+hjF4dnsK8=;
        b=F6zhuDRUQy6FGhjiNPQwvBbPK3SQNVC4AiHMAV8rItKXj4omU/LqdANw4pI9phI6UY
         UVwGO+9rZM/tITpBGX6sf+HA5ZKO9pPHWJCYPzN8d60VlpbriZH0jqTnCH9rOfbzI1am
         fxKhl7hfEvCFqhCcXwHToxI3yJr1cILh5sszKHbQftOrJ9wgW1ZGEQk2epi8Tz0Ee3t2
         4e8aS5Ahow23XHGR8cjP9IfdaVm27etDb47RTrKU9bK6uikivYhvG/yZB8HZUo67KmUS
         +W1/DpJs+j3pBrrbMIZrCM1MsHWU/bCzyCvDdDru1dt/DdjeFhv0LanPYc0KMFwrYG1j
         oqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744663718; x=1745268518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9tk6CJZkAx7VMPFGCksrX4w7MMdB53eC+hjF4dnsK8=;
        b=Mlj7yAlNDbLJu2GZG6exLw3+8dDFQKMZ/FBw00e2J2a4ly2qoVCJKIEAEwoLAGJCm9
         AzeUvCYVph5KSlmXFK8XRqji0XMXAU49ilDJvZ88/k/uUEXP/TSGD9xjIBYfp01FpQxi
         MMCWFOY7RtNxqs/2RLHBoVDHBilLTWG2F8LfUHf18sMgie7SOpOqHBD6sWxC+UvgDVAm
         J7BN+ktGIXdekPCIpfyxDq55FgrlrICpyz5WOY03eXxMTb7Hmg2bRgHEaT/bbw7BkRrX
         2YdbaZ/EUMgj8V6EC4+blwTp6/s3t2N7yvUrMKn1Hz+caYwY8ugblG135oafdTM5YYZt
         etSg==
X-Gm-Message-State: AOJu0Yxr/FbzLk0CRVtV+Fv2fXB7HPp42c4eyxl5acxTMcmRJ7IAsxXH
	cmyZV0MMhf8ej/2XYUKWYRYZo3bS01w37Lp5LeFlM5GexoifQSDEta8lFA==
X-Gm-Gg: ASbGncuSSq9Y+dqE2q7fkK7m2i6LX1UAGjZaeiIXa5Zox16dBWrX7Kb8SiMqWvkNRO1
	8LU9ap9RMsePoaKN61qKWIVUMNkhC9+9W4XILFWG5wfOd8imQVCx3le96hwxX2xA69v0Rr6IlN0
	S0sN4IxIQt7h64T11UUmrV2XzTmeXeGB1k6NV1VilIp3WGjxRcBTu7HOIXJ96rAJJQNGif/x3zM
	Ia0V+dIdbX/4ue5TK0JMb21QmLiJKTEsJ/mbBNmOwQARUHxuLXPaKw4REbXBHoOlXlxpKgFw9yL
	Idon6DHPZpE4Lmmgc4NPYcYw83pz4BI1Zo3HhIqtyiy0
X-Google-Smtp-Source: AGHT+IH7Qbf3n9+RXEo/vMqJihpnudebUvdur3l4J9/D/CA01iNESsobNwHMFg7U8Uzwg8IpRkhxAg==
X-Received: by 2002:a05:6a20:d049:b0:1f5:7f2e:5c3c with SMTP id adf61e73a8af0-201797876e1mr20024098637.1.1744663718089;
        Mon, 14 Apr 2025 13:48:38 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b09da8ff1c1sm871081a12.39.2025.04.14.13.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:48:37 -0700 (PDT)
Date: Mon, 14 Apr 2025 13:48:36 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, gerrard.tai@starlabs.sg
Subject: Re: [Patch net 0/2] net_sched: Fix a UAF vulnerability in HFSC class
 handling
Message-ID: <Z/10pAy7sAUkhu9u@pop-os.localdomain>
References: <20250414010912.816413-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414010912.816413-1-xiyou.wangcong@gmail.com>

On Sun, Apr 13, 2025 at 06:09:10PM -0700, Cong Wang wrote:
> This patchset contains a bug fix and a selftest for it, please check
> each patch description for details.
> 

Gerrard reminded me hfsc_dequeue() needs a similar fix. So, I will
update this patchset to include that fix as well. I will post v2
tomorrow.

Thanks!

