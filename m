Return-Path: <netdev+bounces-167672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D88CA3BB07
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 11:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4DD3A2BCC
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 09:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873B31C700B;
	Wed, 19 Feb 2025 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tj/C6Uc9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66A013DBB1
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958822; cv=none; b=OouP7Irv5ljreJTplthswQNcWgvpZfrueAZlhswpBT13jkL8oMaZgO52bnPl+d9uMT+RVjrCyf2p/e1Pina+AeDy8v+uwN8uUGZx3HM2TdRoS/miN0Cnro1x/NrAHlN1YrEX2qis+w63tuBAuhIqurcxxqxC9g1sid9ooPpIVao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958822; c=relaxed/simple;
	bh=y45hZ4DgV9WKtvdhiUABAWt383J25Aqy+Pd8zN5CAmY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nuoXFy3Q5AMp6kIbVIfnkzrCbBPz0dxrNyzDZpY9uY6/RWDjF/hTdcXSyUHh3fXAplQpie6kahOAJESeoSwRcXJrheFR548Eov1OPAZ1KIAWxezdmVKtKHa0cY0M0wlcJ2JyPpD6WFOAmmo8lWUNUD4QgP+K22NBIJM3txj2OzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tj/C6Uc9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so850274266b.3
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 01:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739958819; x=1740563619; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K9c8lrVrNeUAhwTGNeKr8VzQaX0Ok+zzQEXaOXHHQy0=;
        b=Tj/C6Uc9sZET/FZBMPUnROw1jfBRwhksbpU0OwJuwSVaP9Fx/+pVkKV38dgophhoed
         lKUKFhpbqNmUKL5zB5/hECn6Z5Pm+levYFoBH/QxKJo2BCDHGOtoHju26s/JJWojbDJK
         zf9e2opqAAsfr+iCM8vhM9XXkf8S9vpBt7NnBdqc8vjgw3XaBWbfy2J3hAQIyDzzdeUu
         P9b1sBs9urElcJI30dIAVsL4GEp3IYrb4UfbEY2J8LpPRLpXIiQhYNECf8zaWYxc4Qjy
         rDDgHgGHhxkIWytozKX30o8RmaJlu3GV3zMKWqQCGAcSRVgpCIsS6i+eHbxXt3t9Tcoy
         aGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739958819; x=1740563619;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9c8lrVrNeUAhwTGNeKr8VzQaX0Ok+zzQEXaOXHHQy0=;
        b=LpY4DiMUiHCZT9N0pZC6lPEA+m4fWfRYVpd7fsFX654YCDukQO0UPHLnYQWi+ZaKLC
         AVcY2P+v3Wjhh7VJHhw8ZkzRB/v7Bnd0AXBCs68jWoj2PgONa5NNeYSxKr4GiNEnT0nX
         G7+SCSdWKuT90/IZUFPAAqt2xjXQcZGlv6NsGmZRGv/G+lAtUFeN84LlG4HLhuqtrYai
         JvUBE/EE2vDT3HQ/IC7SMGTdxemcPM9dxf9cqKJOE09pffVvyBdsM17B9N51AKV96HCP
         LNFgmxcN+RM3n5UQUDE4xlSaK+e5S22TvWwdJ8t40XXch6dJjAlui6ubOmRScqarPVYX
         AKjA==
X-Gm-Message-State: AOJu0YzpiTR0WzJZHq0ePs3dYJYKO1RHQS+XEdVEGyR8Fn81Ws8Ce3I3
	I2QW/XztcJl5NlpxJJnKm6+C9AC7eccuuRFSRqucBPbIZ/mPv3CZtZdUoRjetnk=
X-Gm-Gg: ASbGncsVOzZZU+e3SKdSnWGK6T3O/2kDrJxkihI33p4c/CKsTSx2DyPFQx+Zkqqb8iF
	iwHI8URlk5fafgdTuhDeHOAITqkS1vuui18T/LRGc5rlhFFKHoIZyioaw9lbyBMuqGVId2vxPHs
	kmrmS/VN9zVY/CR7H79jVeHtd5+y/tS8TVj11w+xYW/o9k2OrOUwddbaAoblXt8uLzlH2pIokyR
	pKjEjMkDcAH3UcSpgB/Bpqd343KRC1Rvdqsu3F8FyfQ1acluqjMdyrxtFYq+iMtddwfDAsxA7ZC
	RCBCnz2j/n2JReCvJdsK
X-Google-Smtp-Source: AGHT+IEpHeFTagiZlQF/eMtwsC1Q0FNv50hYgFwxaKnI4A0RPErTOOF9Wm2+xyxNFVx9Y3mB7sS7Aw==
X-Received: by 2002:a17:907:7e96:b0:abb:6ea6:161 with SMTP id a640c23a62f3a-abbcd111d22mr312486166b.56.1739958818881;
        Wed, 19 Feb 2025 01:53:38 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aba910e8b11sm949257866b.21.2025.02.19.01.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 01:53:38 -0800 (PST)
Date: Wed, 19 Feb 2025 12:53:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jiri Pirko <jiri@resnulli.us>, Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org
Subject: [bug report] devlink: introduce object and nested devlink
 relationship infra
Message-ID: <21d29137-57d7-47c4-be90-ca7fc1c4978e@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jiri Pirko,

Commit c137743bce02 ("devlink: introduce object and nested devlink
relationship infra") from Sep 13, 2023 (linux-next), leads to the
following Smatch static checker warning:

net/devlink/core.c:118 xa_alloc_cyclic() also returns 1 on success

net/devlink/core.c
    108 static struct devlink_rel *devlink_rel_alloc(void)
    109 {
    110         struct devlink_rel *rel;
    111         static u32 next;
    112         int err;
    113 
    114         rel = kzalloc(sizeof(*rel), GFP_KERNEL);
    115         if (!rel)
    116                 return ERR_PTR(-ENOMEM);
    117 
--> 118         err = xa_alloc_cyclic(&devlink_rels, &rel->index, rel,
    119                               xa_limit_32b, &next, GFP_KERNEL);
    120         if (err) {
    121                 kfree(rel);
    122                 return ERR_PTR(err);

Obviously, returning ERR_PTR(1) is not allowed, but I'm not totally clear
on the rules if xa_alloc_cyclic() can actually return 1 here.  Although
even if it can't return 1 here we should still write the check as

	if (err < 0) {

    123         }
    124 
    125         refcount_set(&rel->refcount, 1);
    126         INIT_DELAYED_WORK(&rel->nested_in.notify_work,
    127                           &devlink_rel_nested_in_notify_work);
    128         return rel;

regards,
dan carpenter

