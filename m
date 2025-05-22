Return-Path: <netdev+bounces-192844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4451EAC15CC
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 23:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF1E1BC6A75
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 21:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A4A2522BB;
	Thu, 22 May 2025 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWGAnOir"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48522528E7;
	Thu, 22 May 2025 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747948219; cv=fail; b=sIDZhW3zNFpHOm3mGS+NvYSWMa/ywzYX1TpeHgGNi7o1wz57Jo+iBNZgccwXSAa2umg/kjPOI3iCXZDWNEvZm8ZHNRShhLyUTozU3Wfkf2BOC3yBv5w8oA/B4rWHgzKk75aO61cov62xJQNKvvlTXALe0+OucVkESJu+CNWD8vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747948219; c=relaxed/simple;
	bh=HcQkpNvW8rnYfU13Q6HrOcT+UWlqLshQHvWq4hngTdE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k2Ypdh8uTtrMCCmt2XdFBnNiOn8zqJcY3qxMEVz/K2MNnQe3MUTJj4eNrmnJIRdFzuuaILDniJtTHn3zJgiupK9LYR62KOokRDXCQgIbCb4U2UChsIoqHFKfvI699tOOAVIUPO1pWINJf+hI7yss5amxsLS3aq1BoWrrhqvnKio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWGAnOir; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747948217; x=1779484217;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HcQkpNvW8rnYfU13Q6HrOcT+UWlqLshQHvWq4hngTdE=;
  b=TWGAnOirtY4tyfrAmoCrJvHwMl4xYqI0k50Jjadkg4F2RsKSFHC+SF48
   nPntej3OUp5Hye+niYxTqwPSSo5/1cSENHhH70Yy+qWQ4E1Zo9QFucvlJ
   p7fgC6m9rHzKtWehVNbBTrlAQCH5vlIBasgnIhlHoXgheZJZ+OWwNjx+S
   vKFw8CgDHuG/6xOtiphMVJ9iNMJ82gy9LxK08DPYU9dNt9YUAdkI8/dco
   0AKTS+M1q0Rl2FBpp0DT35kjSrcOXQzZeWg1QLZ94KPLDzr2fWogbQLgN
   6fjcy+W09XzUlTMKLas7iyX0/elm02NmPPuLSjVGIRgHW27KcxPXcQA3z
   g==;
X-CSE-ConnectionGUID: jmO2b7VrTvSzFNHjU2voLA==
X-CSE-MsgGUID: L27CTS5WSCaXQDnNROrYVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="60649525"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="60649525"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 14:10:15 -0700
X-CSE-ConnectionGUID: WjDe40WGQty9Zhe0XKKS5g==
X-CSE-MsgGUID: DdsIMVbkQjKBl598+TsgiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="145935080"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 14:10:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 14:10:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 14:10:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.61)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 14:10:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nv7ZEqP5iQWCsbFEiZUXZbuwXy4CcauvzIXJkJH/uUcQr6r9YyZWNdAZu2hxOWv2qc8MYpYDSGJhVmHTFbae3bDUHXHNEiCZuchtZDLWbtQLKcpLLlM+6r2yWhrYD7iefiUfHOnJrAeox//lZmq3WRfI+RjDw1YDYHEofLGuBNuhjcHfmkXguFqegRvoWpxDZpOKz1LXbYGCYKhwdnwXfED9GrcBZe8lw0ueQos5o2aP5iHjnEXaXM6j27uGhDjaKfPB7tQaU4ovMAV+e5NxYZnivEWMZuq1WVbtnyeNfBOeXd4o3Y6yybomUJc0F9x5BPTv1E2OEoNNfMBfnuH1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Uf9Dm3IL/fHCVf4r6d3ftQYc3W0hny/qSUVGwtYEVc=;
 b=V0tzSqmjxuQeHufkuJIdO6fuGmXycDu7xpFA+uFrpob7Xjgj7PUM4qSex6AvLNhxzt5LsDySw+9zMRHGBfiwIkj1Qi2RZ8OJ8lH/jLrOwo8EyHodNfrcWKFyfi8ilZ1dUB+TwUTYIZso7uzBe1Ic2W3cbSkf3oUmXUFWcXzOogySkdYLEzGIo8fvixyvlXwyunxKWMQpar2QDl7eR5br3hwixpyHjSOYSnuD/SY0Ny/0qc8mqcOdiKVYTC/Cincr94qpWVGkWTwhnq3Lx4XaBQ3ViE+ca2UwJNMRSTN+Tt/WdAysHd3waXPSOOBBiVx7j/+A/dDlgFu6pPdYV+KDzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 21:09:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 21:09:43 +0000
Date: Thu, 22 May 2025 14:09:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Alejandro Lucero Palau
	<alucerop@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Martin Habets <habetsm.xilinx@gmail.com>, Zhi Wang <zhi@nvidia.com>,
	Edward Cree <ecree.xilinx@gmail.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v16 06/22] sfc: make regs setup with checking and set
 media ready
Message-ID: <682f9294aaa8a_3e7010044@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-7-alejandro.lucero-palau@amd.com>
 <682e1ccec6ebf_1626e1009a@dwillia2-xfh.jf.intel.com.notmuch>
 <5b20031c-ed46-4470-b65c-016410adf5c0@amd.com>
 <682f8797ac1b_3e7010017@dwillia2-xfh.jf.intel.com.notmuch>
 <682f8eb15905c_3e70100b5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <682f8eb15905c_3e70100b5@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1a42aa-5567-4b76-3bcc-08dd9974f982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0xq4cLb+n1/qBCeBAo1QVUhbPG/HWIOv76RIsg0lPnh1EkoJ82V28WzRgL/3?=
 =?us-ascii?Q?jQjUtCrzO1zlgMXVogK06h3yr3oUhxC3p2BYWbMGvzlH/H9+DuqFtIHea3Fe?=
 =?us-ascii?Q?uETNacN3BrBnTaH4htT25EP/qbe4o+6gi6t/Dc1v7mI1ETD3ZUYimyBThb6G?=
 =?us-ascii?Q?l5KpKBY/LaFDd5cCbY9xJMvhUQSUJxdCPDuMpxWClkLpixKFOnBNJqdRS8qE?=
 =?us-ascii?Q?bDT/NmxLKce4ltDojDPL8NasMMWDH9r7gDUek/m80hz4S1I6QeTk/DpAF+z2?=
 =?us-ascii?Q?G20+QxeGitpU0DvK/csliaRhqeAGbmpzDyFXZVsATgOHHhdb/BDfQUvZQPKl?=
 =?us-ascii?Q?BgTQpogKba3hp4tFJFdZcOWkE9Aw9R2ybQJt+D53OX5sLBEArbs8ekK88e0i?=
 =?us-ascii?Q?c2aM96eUwe7aX3kso9U2xdqj7//mZBo5axsXmLp5mYYuW475xjAlhszl48I3?=
 =?us-ascii?Q?CVXv6Tm5Zd0OdBr5FaOsLhFqy/oME2U+FxoFh2dFML0Bhv864Co2yitQId0b?=
 =?us-ascii?Q?hl03WRM6PXeTYTZznLv/bzBfkgkBTEc2Qq3DlX91o9YbAwsY/1mrCp7zvynN?=
 =?us-ascii?Q?SmDql5+RJbPqBu545tjsOFc+8D3NAmIOYjEFMKcw5/pffaM3iFOnOEx9focQ?=
 =?us-ascii?Q?SYFkUq6Ate0pxWKjS7TLNWBAnGWUV83etecOx5wSyzww49DT7OWynfDzxN6+?=
 =?us-ascii?Q?NYJlX+q3CA8ugBKV0H/xtthgjOcbrG61sgxzOUOkJjZ5UqlRH5ZEGaz3uz7I?=
 =?us-ascii?Q?y7zlFfR/WMx9p3vuGt1g9GFe0f0C4Wz7IY05IXk3OqZR8BPJvPCQYmuWuOJ1?=
 =?us-ascii?Q?xqGDRkcdVBJ8veMWipYGFrZtDVeWat7VxiL43Au2lkamOx2R9pKp7lh0w5yJ?=
 =?us-ascii?Q?FJL7el3JEiPDWvVgcfEPrkcqpsVAH5swrrRBPRjx++uhELfwIswEbILnFFPE?=
 =?us-ascii?Q?T3agHASihQfohaJseiwTyAXv4EbHnsAX6S06SdILD9l0+7NxvcjxBfWIdvhq?=
 =?us-ascii?Q?3Oo03GYO2pOIsNZlcFFB1iSCq263mRbfpEPxfeTVoYRMoLSe4fgdMfIDl9lQ?=
 =?us-ascii?Q?xfHeVcShK8R13Cj+bQ8Typy5ikrD//PYvFj6QvN9FZ5ef2k8yB2cOdVOPdGB?=
 =?us-ascii?Q?CRKnJ3G/zLwz24s+mjUWBM11xQdoz3U1DyRx3IOYMO1/wz+tZKlRqsKKOxK+?=
 =?us-ascii?Q?DYcX7VbHZMSV6RcX0dMHGSJEuBbKzL0IUl+oPymsV9MGZd68YcLYC/46fa3x?=
 =?us-ascii?Q?8qpIpQ0JaeyvBiuPhf1ci4mNeO4zMMqa+PyXbCSD63f9nhZw3GI9l7sTYGDU?=
 =?us-ascii?Q?00QCFjDtO8h6zyoB6Yvc+57k5SQT105kLMBpv3ni2oFbB8pc/o8LjYW5rnpc?=
 =?us-ascii?Q?xfcDFnrMUfcOi9/+AcOIXttLVervpmW9v0pWXLL/7nYevgIJFdE+Bvo3eDWf?=
 =?us-ascii?Q?SDu+rKC+akRjn8QXtYZL1ltedcSMMZMdb9KgwyplAH0KFw9DeF1oFw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pCxnLaQ66KfXrldUNkZieEQnwkV0I+TzHgVcesmd8CQuFXu9amLyZ00V+R34?=
 =?us-ascii?Q?FaxCJ3tP3YRPAbwylDg8ZBhj+wYHDK9e5xoar0RgHg1LSH91TnWRCSqUfucX?=
 =?us-ascii?Q?IGy5T+UJaEgMLv2iJZdOdJktExduzu4mi5Q3xD053uc/ljdTCzi/9eJ68TTv?=
 =?us-ascii?Q?++HaC3LvTQxxNlsb5/rby7Ex0eTUgWv1mzK24gV8pYdOF+ZLBd7kCCi9oLcw?=
 =?us-ascii?Q?Txm74SI/IyunINFoCBBzYrfgstujukoB8j34StT5G5uoB4pviM8w55ys0kfm?=
 =?us-ascii?Q?IxxjPNsgyPMY1hbR37OiqyToDoGgyD7hHvCpLbIKKDkbV4+kRb35VGwDCwdL?=
 =?us-ascii?Q?87I0osnYLJLh/lfuzpVachnSqdyCKcvTOrmAtkvxsQCZaqyVBU/TJivVFjEa?=
 =?us-ascii?Q?xZp2EGE9/BYIbfE2+8sU/5zFzo2XGCkdZygnnNFniPIWEglKpGCc1JL40qky?=
 =?us-ascii?Q?wVcuph6DrEDX7ZeUgX8A1qrtmXHZU+EeVZYjcSqEshBEkHDavlU54xckBX+o?=
 =?us-ascii?Q?zFqSCkLyO+Xu91utH/c36BhTxvgn8qCVaCu4Tk9zXXEZSUNwsP0xqrVYxlCu?=
 =?us-ascii?Q?XaGWWMi01CDIzfeaVDciJ5tCWjbLNCqPGywe/IRzBruQ/vR+6ujcd6PeWxlE?=
 =?us-ascii?Q?FAC6CMLz2S+G/6NrpX1hVjrIRZXkSjm5dJPsnbe70HSn8rDVer5Hv0zydH+Q?=
 =?us-ascii?Q?nj26btxWwMwDBR8Ksj0BduVzuaNnR06nN1o9VMhNKYw94+sCcs11zla9cCnP?=
 =?us-ascii?Q?ZAXK88pJFfmeiyRXarTpjuWwLp8qyFsyZ/PzgI66bRcIzGJSinbXpvNSVaxM?=
 =?us-ascii?Q?NB67qIgrwdEcDBYlgBs0T9aqulu0GQzACPOmrh1VJaii5exJzQWbg7MN8bD0?=
 =?us-ascii?Q?xldfGex2823bBVf8gmlgcA27AAPUPBtBg8HGw6h1MXGug2zzHP8aLxEx28eh?=
 =?us-ascii?Q?sg3X/GoI0Q/aKImcEOmESHNBP1kqy6//uo86MUn6GK8ch14PSPBo8aCmYE3s?=
 =?us-ascii?Q?K0P+X/OtuKgW/J9mt/9oVL2RZQac2x6xFc1nCUOmkxp053D9RB+PnNgw9aNS?=
 =?us-ascii?Q?0P5MqM6Ki869CRFzUkBPRvHjXe53c4nkgXcfd5M3QHxC3+l8xjhqDyE4ga7j?=
 =?us-ascii?Q?KQMKrrR2nLfwaVJ5Qtx5buqhpBYgkG0yRM51cAEZGyRj0/jRHyiVTk9vukr2?=
 =?us-ascii?Q?cIPG9SRhvjUiPZCn3ZYjb26y2xByE+G/5SQkCRhAShMsfOvudaOMD7CqrFSu?=
 =?us-ascii?Q?0bPbZodO26PyW4iqInMT59IYolDtSOOCDBa7SiE6HuaqwOQGH2wwsISLJLP5?=
 =?us-ascii?Q?ESQ8r/XyM5NPC/lx0Ikzl1JT401exJgw2yNf6qQ3l1hnqpqBx65sz4c0XnjD?=
 =?us-ascii?Q?QJivm5WhVXa7gqefjcHGV/IO9Dxf70GNsFtzvx7vWYyWOGZWJjaix781XtRN?=
 =?us-ascii?Q?HSCfyOKKEr89IioVlC/ZUQSyGzk1kCAqeQB2+QEmJ/pKNbR0TJnh0euCR9zT?=
 =?us-ascii?Q?4WtIXGgWrD+jzKltLTFW9lwo5KTiJ0wsU6fxv4jhxsZMJTkyhpABIf4BoZFx?=
 =?us-ascii?Q?m14//XZ9dX7q3Gz9Y50v7Gq0b/HfPbXKIURYjNIlIzaoFCADtEV8h46664jb?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1a42aa-5567-4b76-3bcc-08dd9974f982
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:09:43.8893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUj3i3MceZWYy/7igTOJFkywoIcGHF6cOBbR6996Lm2Qtt+SxQOeGH3mJuONtX8CaTRMZI+UojVWQcwHIAKHNNUwahePA125dZgZbFGhXVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7828
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Dan Williams wrote:
> > Alejandro Lucero Palau wrote:
> > > 
> > > On 5/21/25 19:34, Dan Williams wrote:
> > > > alejandro.lucero-palau@ wrote:
> > > >> From: Alejandro Lucero <alucerop@amd.com>
> > > >>
> > > >> Use cxl code for registers discovery and mapping.
> > > >>
> > > >> Validate capabilities found based on those registers against expected
> > > >> capabilities.
> > > >>
> > > >> Set media ready explicitly as there is no means for doing so without
> > > >> a mailbox and without the related cxl register, not mandatory for type2.
> > > >>
> > > >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > > >> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> > > >> Reviewed-by: Zhi Wang <zhi@nvidia.com>
> > > >> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> > > >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> > > >> ---
> > > >>   drivers/net/ethernet/sfc/efx_cxl.c | 26 ++++++++++++++++++++++++++
> > > >>   1 file changed, 26 insertions(+)
> > > >>
> > > >> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> > > >> index 753d5b7d49b6..e94af8bf3a79 100644
> > > >> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> > > >> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> > > >> @@ -19,10 +19,13 @@
> > > >>   
> > > >>   int efx_cxl_init(struct efx_probe_data *probe_data)
> > > >>   {
> > > >> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS) = {};
> > > >> +	DECLARE_BITMAP(found, CXL_MAX_CAPS) = {};
> > > >>   	struct efx_nic *efx = &probe_data->efx;
> > > >>   	struct pci_dev *pci_dev = efx->pci_dev;
> > > >>   	struct efx_cxl *cxl;
> > > >>   	u16 dvsec;
> > > >> +	int rc;
> > > >>   
> > > >>   	probe_data->cxl_pio_initialised = false;
> > > >>   
> > > >> @@ -43,6 +46,29 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
> > > >>   	if (!cxl)
> > > >>   		return -ENOMEM;
> > > >>   
> > > >> +	set_bit(CXL_DEV_CAP_HDM, expected);
> > > >> +	set_bit(CXL_DEV_CAP_RAS, expected);
> > > >> +
> > > >> +	rc = cxl_pci_accel_setup_regs(pci_dev, &cxl->cxlds, found);
> > > >> +	if (rc) {
> > > >> +		pci_err(pci_dev, "CXL accel setup regs failed");
> > > >> +		return rc;
> > > >> +	}
> > > >> +
> > > >> +	/*
> > > >> +	 * Checking mandatory caps are there as, at least, a subset of those
> > > >> +	 * found.
> > > >> +	 */
> > > >> +	if (cxl_check_caps(pci_dev, expected, found))
> > > >> +		return -ENXIO;
> > > > This all looks like an obfuscated way of writing:
> > > >
> > > >      cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> > > >      if (!map.component_map.ras.valid || !map.component_map.hdm_decoder.valid)
> > > >           /* sfc cxl expectations not met */
> 
> Now, I do notice that the proposal above got the registers blocks wrong.
> I.e. that should be:
> 
>       cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
>       if (!map.component_map.ras.valid || !map.component_map.hdm_decoder.valid)
>            /* sfc cxl expectations not met */

Actually that is subtly wrong again and points to a shared wart that, if
it could be cleaned up, would benefit cxl_pci Type-3 use case as well.
That @map unfortunately needs to be cxlds->reg_map.

I do not like the fact that 'struct cxl_dev_state' carries that 'struct
cxl_register_map' just to forward the enumeration to the endpoint
cxl_port. I also do not like that cxl_pci maps the RAS capability while
cxl_port maps the hdm_decoder capability. Ideally cxl_port would own
both those capabilities.

In that scenario simple use cases like sfc that only care about HDM and
RAS can forget about enumerating and mapping CXL component registers
altogether, just devm_cxl_add_memdev() and the core handles the rest.

Now that is the kind of helper and CXL core improvement I am interested
in seeing, and perhaps precludes the need for 'struct cxl_register_map'
to be moved to include/cxl/pci.h.

It may be something we can do after Terry's CXL protocol error series.

