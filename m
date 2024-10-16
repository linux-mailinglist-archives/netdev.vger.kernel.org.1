Return-Path: <netdev+bounces-136305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C2A9A142A
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A434A1C21D33
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9B921643B;
	Wed, 16 Oct 2024 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="AM57Dk1k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D42144CD
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111209; cv=none; b=BXr9yHoYr0aSUdCH0oMJe/VaUTNsUvmtq9tMo/LAYqrpHmkQMmfjGFfpMigML7oGuXUfarzeXHCKpimNXTnQmPzUUv2INtqhGoONixEezkM2bye6Wsux2ync/UuwbClNuvGaGChpOPqLHyu1lT2jXQcIt6Cg1/4guEqODwCm+NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111209; c=relaxed/simple;
	bh=+ZhmjY733F1gROFYepfH+/BCr+cGlFRNdGmMnzv/Ph8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YJ3kv/fqr6HzZBH9TY2MWF0Cw49ZvliTzQ+eTA9/hWyeSTuiUUuPS7Wd3xWRA1ewMpuCRYHHmRTcCp/1qhny6uLePR7dxWg4Ab5tTQf/HgXU6jL723FJj96r91FIpYrz14WIbLwK+zcq0b+Aj0oDMqcp0keFEMcy0pHm3R/CszQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=AM57Dk1k; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea78037b7eso217304a12.0
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 13:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1729111208; x=1729716008; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MEKOnh1s2+0Rhw9pEZcf4Hw/wzdiXLK0w21/+OOxAS0=;
        b=AM57Dk1kulhp+iUb2dXt9CjNnCjXs3HjIihLmB1tmD5yzn3BP899NA1hH6dgLvZSYx
         MU7fibYMBwDo33TBc0GGC9nFS55o5Oo9YiesTMOGSk6EVEDQuARZcKRmQUNWuN06yHuv
         gG7oq2XOUzdNrc2ZiOOV+iE81iDr+jipUME1IFxKkB79aRefByOix49PXytKioGNvOex
         PWM4E1nwcQVjN8lbcauSQNiQihixUx72+23HK21xAp8TsTs9e/gF37LmYMUr01ZMHYUc
         8cXMSGCvepU/FXBVNRl7rul/y5nJ1Ei/BXJOOQUl5cCOSnwB5zlTrNlPb4Rz+Lgfabnk
         lGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729111208; x=1729716008;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MEKOnh1s2+0Rhw9pEZcf4Hw/wzdiXLK0w21/+OOxAS0=;
        b=tXLB01JVgHFHmZJ65r8J0yhaOYJzNzJhjoVaDtVt/9czI63T9lqGEnzAenhrO1KN1O
         SX91DU5btvWfrLWfRpOGxtAsCupyvWNrQUtO8BR04LtFAhAyVQjadSZ8PSlSE0eIAqDI
         6MfKMMYy/TOatii0sYOuuikUG5rqF3wWqzTsO0Ct/3PYNzWSIu/Y8H69QqqmbT4FsfXx
         t1TfjglGqtGZ+fLesR0E+THAaisz7AgwPXfMHQ0zmo00Ebka3uyIwme7E4QyI/TiW+V2
         ny/CtjDGH9H5Gufb6s/PPxlGaNahHZ36VenW4rEMsyekOEUWDZufISn+TZ7xek7Urd7W
         42Zg==
X-Gm-Message-State: AOJu0YzOUWnvkFTe7wYwSbow7umNO5VWz/Wxk7m/DFgVseP20UydYASr
	12gG7DJcjaGbVmFjibd9ocgMQFTIkXRWeBiIz4zUgk5Xd7p1FB6zVTfL41HY3oOJsljQTV2gHYS
	p7WPV2P7NEworzjrtCmJ/Tv/TnJxACGHci4q2
X-Google-Smtp-Source: AGHT+IEbFFROjL1FU0OCz7I4lJZn5uKKHUhDn7xSQ7tnQ99D4R9aHpb71O/gXX3HUDgGL1eJ9e6IjJEbslXU5A37su4=
X-Received: by 2002:a05:6a20:db0c:b0:1d3:293d:4c5a with SMTP id
 adf61e73a8af0-1d8bcf3e6e8mr25964774637.22.1729111207840; Wed, 16 Oct 2024
 13:40:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 16 Oct 2024 16:39:56 -0400
Message-ID: <CAM0EoM=G_eRhdCgMX--H=U+9phAbxwyW4-Y3W+t_ZFtgQCqkPA@mail.gmail.com>
Subject: 0x19: Dates And Location for upcoming conference
To: people <people@netdevconf.info>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, Christie Geldart <christie@ambedia.com>, 
	Kimberley Jeffries <kimberleyjeffries@gmail.com>, 
	Lael Santos <lael.santos@expertisesolutions.com.br>, 
	"board@netdevconf.org" <board@netdevconf.info>, lwn@lwn.net, 
	linux-wireless <linux-wireless@vger.kernel.org>, netfilter-devel@vger.kernel.org, 
	lartc@vger.kernel.org, Kathy Giori <kathy.giori@gmail.com>, 
	=?UTF-8?B?UnXFvmljYSBQZWppxIc=?= <Ruzica.Pejic@algebra.hr>, 
	=?UTF-8?B?S3Jpc3RpbmEgSXbEjWnEhw==?= <Kristina.IvcicBrajkovic@algebra.hr>, 
	=?UTF-8?Q?Mislav_Balkovi=C4=87?= <Mislav.Balkovic@algebra.hr>, 
	Bruno Banelli <bruno.banelli@sartura.hr>
Content-Type: text/plain; charset="UTF-8"

Hi,

This is a pre-announcement on behalf of the NetDev Society so folks
can plan travel etc.

Netdev conf 0x19 is going to be a hybrid conference.  We will be
updating you with more details in the near future on the exact
coordinates. Either watch https://netdevconf.info/0x19/ or join
people@ mailing list[1] for more frequent updates.

Netdev 0x19 is scheduled to be in Zagreb - Croatia March 10th-14th.

Be ready to share your work with the community. CFS coming soon.

sincerely,
Netdev Society Board:
Roopa Prabhu, Shrijeet Mukherjee, Tom Herbert, Jamal Hadi Salim

[1] https://lists.netdevconf.info/postorius/lists/people.netdevconf.info/

